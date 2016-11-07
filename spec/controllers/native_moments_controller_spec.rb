require 'rails_helper'

describe Web::Moments::NativeMomentsController, type: :controller do
  shared_examples 'public access to native_moments' do
    let(:native_moment) { create(:native_moment) }

    describe 'GET #show' do
      before(:each) { get :show, params: { id: native_moment } }

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:native_moment)).to eq(native_moment) }
    end
  end

  describe 'guest user' do
    it_behaves_like 'public access to native_moments'
    let(:story) { create(:story) }
    let(:native_moment) { create(:native_moment) }

    context 'redirects to login page' do
      after(:each) { expect(response).to redirect_to(new_user_session_url) }
      it { get :new, params: { story_id: story } }
      it { post :create, params: { story_id: story,
                                   native_moment: attributes_for(:native_moment) } }
      it { get :edit, params: { id: native_moment } }
      it { patch :update, params: { id: native_moment,
                                    native_moment: attributes_for(:native_moment, body: 'new body text')} }
      it { delete :destroy, params: { id: native_moment } }
    end

    context 'does not touch database' do
      it 'POST #create' do
        expect {
          post :create, params: { story_id: story, native_moment: attributes_for(:native_moment) }
        }.not_to change(NativeMoment, :count)
      end
      it 'PATCH #update' do
        patch :update, params: { id: native_moment,
                                 native_moment: attributes_for(:native_moment, body: 'new body text')}
        native_moment.reload
        expect(native_moment.body).not_to eq('new body text')
      end
      it 'DELETE #destroy' do
        delete :destroy, params: { id: native_moment }
        expect(NativeMoment.exists?(native_moment.id)).to be_truthy
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { create(:user) }
    before { sign_in(user) }

    context "is not the owner of native_moment's story" do
      let(:user_2) { create(:user) }
      let(:story) { create(:story, user: user_2) }
      let(:native_moment) { create(:native_moment, story: story) }

      context 'redirects to pundit path' do
        after(:each) { expect(response).to redirect_to(root_path) }

        it { get :new, params: { story_id: story } }
        it { post :create, params: { story_id: story,
                                     native_moment: attributes_for(:native_moment) } }
        it { get :edit, params: { id: native_moment } }
        it { patch :update, params: { id: native_moment,
                                      native_moment: attributes_for(:native_moment, body: 'new body text') } }
        it { delete :destroy, params: { id: native_moment } }
      end

      context 'does not touch database' do
        it 'POST #create' do
          expect {
            post :create, params: { story_id: story,
                                    native_moment: attributes_for(:native_moment) }
          }.not_to change(NativeMoment, :count)
        end
        it 'PATCH #update' do
          patch :update, params: { id: native_moment,
                                   native_moment: attributes_for(:native_moment, body: 'new body text') }
          native_moment.reload
          expect(native_moment.body).not_to eq('new body test')
        end
        it 'DELTE #destroy' do
          delete :destroy, params: { id: native_moment }
          expect(NativeMoment.exists?(native_moment.id)).to be_truthy
        end
      end
    end

    context "is owner of native_moment's story" do
      let(:subscriber) { create(:user) }
      let(:story) { create(:story, user: user, subscribers: [subscriber]) }
      let(:native_moment) { create(:native_moment, story: story) }

      describe 'GET #new' do
        before(:each) { get :new, params: { story_id: story } }

        it { expect(response).to render_template(:new) }
        it { expect(assigns(:native_moment)).to be_a_new(Moment) }
      end

      describe 'POST #create' do
        context 'valid data' do
          let(:valid_data) { attributes_for(:native_moment) }
          it 'redirects to native_moment#show' do
            post :create, params: { story_id: story,
                                    native_moment: valid_data }
            expect(response).to redirect_to(assigns[:native_moment])
          end
          it 'creates new record in database' do
            expect {
              post :create, params: { story_id: story,
                                      native_moment: valid_data }
            }.to change(NativeMoment, :count).by(1)
          end
          it 'creates new record in database with image' do
            picture = fixture_file_upload("#{Rails.root}/spec/fixtures/native_moment_picture.png", 'image/png')
            post :create, params: { story_id: story,
                                    native_moment: valid_data.merge(picture: picture) }
            expect(assigns[:native_moment].picture.original_filename).to eq(picture.original_filename)
          end
          it 'creates notification for subscribed users' do
            expect {
              post :create, params: { story_id: story,
                                      native_moment: valid_data }
            }.to change(subscriber.notifications, :count).by(1)
          end
          it 'creates notification with right data' do
              post :create, params: { story_id: story,
                                      native_moment: valid_data }
              expect(subscriber.notifications.last.info).to be_a(Hash)
          end
        end

        context 'invalid data' do
          let(:invalid_data) { attributes_for(:native_moment, body: '') }
          it 'renders new temlate' do
            post :create, params: { story_id: story,
                                    native_moment: invalid_data }
            expect(response).to render_template(:new)
          end
          it 'does not create new reford in database' do
            expect {
              post :create, params: { story_id: story,
                                      native_moment: invalid_data }
            }.not_to change(NativeMoment, :count)
          end
        end
      end

      describe 'GET #edit' do
        before(:each) { get :edit, params: { id: native_moment } }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:native_moment)).to eq(native_moment) }
      end

      describe 'PATCH #update' do
        context 'valid_data' do
          let(:valid_data) { attributes_for(:native_moment, body: 'new body text') }
          before(:each) { patch :update, params: { id: native_moment,
                                                   native_moment: valid_data } }

          it { expect(response).to redirect_to(assigns[:native_moment]) }
          it 'changes record in database' do
            native_moment.reload
            expect(native_moment.body).to eq('new body text')
          end
        end

        context 'invalid_data' do
          let(:invalid_data) { attributes_for(:native_moment, body: '') }
          before(:each) { patch :update, params: { id: native_moment,
                                                   native_moment: invalid_data } }

          it { expect(response).to render_template(:edit) }
          it 'changes record in database' do
            native_moment.reload
            expect(native_moment.body).not_to eq('')
          end
        end
      end

      describe 'DELTE #destroy' do
        before(:each) { delete :destroy, params: { id: native_moment } }

        it { expect(response).to redirect_to(story) }
        it { expect(NativeMoment.exists?(native_moment.id)).to be_falsy }
      end
    end
  end
end
