require 'rails_helper'

describe Web::Moments::NativeMomentsController, type: :controller do

  shared_examples 'public access to native_moments' do
    let(:native_moment) { create(:native_moment) }

    describe 'GET #show' do
      before(:each) { get :show, params: { id: moment  } }

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:native_moment)).to eq(moment) }
    end
  end

  describe 'guest user' do
    it_behaves_like 'public access to native_moments'
    let(:story) { create(:story) }
    let(:native_moment) { create(:native_moment) }

    context 'redirects to login page' do
      after(:each) { expect(response).to redirect_to(new_user_session_url) }
      it { get :new, params: { story_id: story } }
      it { post :create, params: { story_id: story, native_moment: attributes_for(:native_moment) } }
      it { get :edit, params: { id: native_moment } }
      it { patch :update, params: { id: native_moment,
                                    native_moment: attributes_for(:native_moment, body: 'new body text')} }
      it { delete :destroy, params: { id: native_moment } }
    end
    context 'does not touch database' do
      describe 'POST #create' do
        expect {
          post :create, params: { story_id: story, native_moment: attributes_for(:native_moment) }
        }.not_to change(NativeMoment, :conut)
      end
      describe 'PATCH #update' do
        patch :update, params: { id: native_moment,
                                 native_moment: attributes_for(:native_moment, body: 'new body text')}
        native_moment.reload
        expect(native_moment.body).not_to eq('new body text')
      end
      describe 'DELETE #destroy' do
        delete :destroy, params: { id: native_moment }
        expect(NativeMoment.exists?(native_moment.id)).to be_truthy
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { create(:user) }
    before {sign_in(user)}

    context "is not the owner of native_moment's story" do
      let(:user_2) { create(:user) }
      let(:story) { create(:story, user: user_2) }
      let(:native_moment) { create(:native_moment, story: story) }

      context 'redirects to pundit path' do
        after(:each) { expect(response).to redirect_to(stories_path) }

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
          }.not_to change(NativeMoment, :cont)
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
      let(:story) { create(:story, user: user) }
      let(:native_moment) { create(:native_moment) }

      describe 'GET #new' do
        before(:each) { get :new, params: { story_id: story } }

        it { expect(response).to render_template(:new) }
        it { expect(assigns(:native_moment)).to be_a_new(NativeMoment) }
      end
      describe 'POST #create' do
        it 'redirects to native_moment#show' do
          post :create, params: { story_id: story,
                                  native_moment: attributes_for(:native_moment) }
          expect(response).to redirect_to(assigns[:native_moment])
        end
        it 'creates new reford in database' do
          expect {
            post :create, params: { story_id: story,
                                    native_moment: attributes_for(:native_moment) }
          }.to change(NativeMoment, :count).by(1)
        end
      end
      describe 'GET #edit' do
        before(:each) { get :edit, params: { id: native_moment } }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:native_moment)).to eq(native_moment) }
      end
      describe 'PATCH #update' do
        before(:each) { patch :update, params: { id: native_moment,
                                                 native_moment: attributes_for(:native_moment, body: 'new body text') } }

        it { expect(response).to redirect_to(assigns[:native_moment]) }
        it 'changes record in database' do
          native_moment.reload
          expect(native_moment.body).to eq('new body text')
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
