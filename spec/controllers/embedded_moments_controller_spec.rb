require 'rails_helper'

describe Web::Moments::EmbeddedMomentsController, type: :controller do
  let(:embedded_moment_attributes) { { url: 'https://twitter.com/fahrenhei7lt/status/765376955697008640' } }

  shared_examples 'public access to embedded_moments' do
    let(:embedded_moment) { create(:embedded_moment) }

    describe 'GET #show' do
      before(:each) { get :show, params: { id: embedded_moment } }

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:embedded_moment)).to eq(embedded_moment) }
    end
  end

  describe 'guest user' do
    it_behaves_like 'public access to embedded_moments'
    let(:story) { create(:story) }
    let(:embedded_moment) { create(:embedded_moment) }

    context 'redirects to login page' do
      after(:each) { expect(response).to redirect_to(new_user_session_url) }
      it { get :new, params: { story_id: story } }
      it { post :create, params: { story_id: story,
                                   embedded_moment_attrs: embedded_moment_attributes } }
      it { delete :destroy, params: { id: embedded_moment } }
    end

    context 'does not touch database' do
      it 'POST #create' do
        expect {
          post :create, params: { story_id: story,
                                  embedded_moment_attrs: embedded_moment_attributes }
        }.not_to change(EmbeddedMoment, :count)
      end
      it 'DELETE #destroy' do
        post :destroy, params: { id: embedded_moment }
        expect(EmbeddedMoment.exists?(embedded_moment.id)).to be_truthy
      end
    end
  end

  describe 'authenticated user' do
    it_behaves_like 'public access to embedded_moments'
    let(:user) { create(:user) }
    before { sign_in(user) }

    context "is not the owner of embedded_moment's story" do
      let(:user_2) { create(:user) }
      let(:story) { create(:story, user: user_2) }
      let(:embedded_moment) { create(:embedded_moment, story: story) }

      context 'redirects to pundit path' do
        after(:each) { expect(response).to redirect_to(root_path) }

        it { get :new, params: { story_id: story } }
        it { post :create, params: { story_id: story,
                                     embedded_moment_attrs: embedded_moment_attributes } }
        it { delete :destroy, params: { id: embedded_moment } }
      end

      context 'does not touch database' do
        it 'POST #create' do
          expect {
            post :create, params: { story_id: story,
                                    embedded_moment_attrs: embedded_moment_attributes }
          }.not_to change(EmbeddedMoment, :count)
        end
        it 'DELETE #destroy' do
          post :destroy, params: { id: embedded_moment }
          expect(EmbeddedMoment.exists?(embedded_moment.id)).to be_truthy
        end
      end
    end

    context "is owner of embedded_moment's story" do
      let(:subscriber) { create(:user) }
      let(:story) { create(:story, user: user, subscribers: [subscriber]) }
      let(:embedded_moment) { create(:embedded_moment, story: story) }

      describe 'GET #new' do
        before(:each) { get :new, params: { story_id: story } }

        it { expect(response).to render_template(:new) }
        it { expect(assigns(:embedded_moment)).to be_a_new(Moment) }
      end

      describe 'POST #create' do
        context 'valid_data' do
          it 'redirects to story#show', :vcr do
            post :create, params: { story_id: story,
                                    embedded_moment_attrs: embedded_moment_attributes }
            expect(response).to redirect_to(assigns[:embedded_moment])
          end
          it 'creates notification for subscribed user', :vcr do
            expect {
              post :create, params: { story_id: story,
                                      embedded_moment_attrs: embedded_moment_attributes }
            }.to change(subscriber.notifications, :count).by(1)
          end
          it 'creates notification with right data', :vcr do
              post :create, params: { story_id: story,
                                      embedded_moment_attrs: embedded_moment_attributes }
              expect(subscriber.notifications.last.info).to be_a(Hash)
          end
        end

        context 'invalid_data' do
          it 'renders :new template', :vcr do
            post :create, params: { story_id: story,
                                    embedded_moment_attrs: embedded_moment_attributes.merge(url: 'srcwrong') }
            expect(response).to render_template(:new)
          end
        end
        it 'sends fill method to model object' do
          embedded_moment_model = instance_double(EmbeddedMoment)
          allow(EmbeddedMoment).to receive(:new) { embedded_moment_model }
          allow(controller).to receive(:authorize) { true }
          params = ActionController::Parameters.new(embedded_moment_attributes).permit(:url)
          expect(EmbeddedMoment).to receive(:new)
            .with(story: story)
          expect(embedded_moment_model).to receive(:fill)
            .with(params)
          post :create, params: { story_id: story,
                                  embedded_moment_attrs: embedded_moment_attributes }
        end
      end

      describe 'DELETE #destroy' do
        it 'redirects to story#show' do
          delete :destroy, params: { id: embedded_moment }
          expect(response).to redirect_to(story)
        end
        it 'deletes record from database' do
          delete :destroy, params: { id: embedded_moment }
          expect(EmbeddedMoment.exists?(embedded_moment.id)).to be_falsy
        end
      end
    end
  end
end
