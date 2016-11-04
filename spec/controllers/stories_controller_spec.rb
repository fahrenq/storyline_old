require 'rails_helper'

describe Web::StoriesController, type: :controller do
  shared_examples 'public access to stories' do

    describe 'GET #index' do
      before(:each) { get :index }
      it { expect(response).to render_template(:index)  }
      it { expect(assigns(:stories)).to eq(Story.all) }
    end

    describe 'GET #show' do
      let(:story) { create(:story) }
      before(:each) { get :show, params: { id: story } }
      it { expect(response).to render_template(:show) }
      it { expect(assigns(:story)).to eq(story) }
    end
  end

  describe 'guest user' do
    it_behaves_like 'public access to stories'
    let(:story) { create(:story) }

    context 'redirects to login page' do
      after(:each) { expect(response).to redirect_to(new_user_session_url) }
      it { get :new }
      it { post :create, params: { story: attributes_for(:story) } }
      it { get :edit, params: { id: story } }
      it { patch :update, params: { id: story,
                                    story: attributes_for(:story, title: 'New title')} }
      it { delete :destroy, params: { id: story } }
      it { post :subscribe, params: { id: story } }
    end

    context 'does not touch database' do
      it 'POST #create' do
        expect {
          post :create, params: { story: attributes_for(:story) }
        }.not_to change(Story, :count)
      end
      it 'PATCH #update' do
        patch :update, params: { id: story,
                                 story: attributes_for(:story, title: 'Brand new title' ) }
        story.reload
        expect(story.title).not_to eq('Brand new title')
      end
      it 'DELETE #destroy' do
        delete :destroy, params: { id: story }
        expect(Story.exists?(story.id)).to be_truthy
      end
      it 'POST #subscribe' do
        expect {
          post :subscribe, params: { id: story }
        }.not_to change(story.subscribers, :count)
      end
    end
  end

  describe 'authenticated user' do
    it_behaves_like 'public access to stories'
    let(:user) { create(:user) }
    before { sign_in user }

    describe 'GET #new' do
      before(:each) { get :new }

      it { expect(response).to render_template(:new) }
      it { expect(assigns(:story)).to be_a_new(Story) }
    end

    describe 'POST #create' do
      context 'valid data' do
        let(:valid_data) { attributes_for(:story) }

        it 'redirects to story#show(story) after create' do
          post :create, params: { story: valid_data }
          expect(response).to redirect_to(assigns[:story])
        end
        it 'creates new record in database' do
          expect {
            post :create, params: { story: valid_data }
          }.to change(Story, :count).by(1)
        end
      end

      context 'invalid data' do
        let(:invalid_data) { attributes_for(:story, title: '') }

        it 'renders :new template' do
          post :create, params: { story: invalid_data }
          expect(response).to render_template(:new)
        end
        it 'does not create new record in database' do
          expect {
            post :create, params: { story: invalid_data }
          }.not_to change(Story, :count)
        end
      end
    end

    context 'user owns story' do
      let(:story) { create(:story, user: user) }

      describe 'GET #edit' do
        it 'renders :edit template' do
          get :edit, params: { id: story }
          expect(response).to render_template(:edit)
        end
        it 'assigns story to page' do
          get :edit, params: { id: story }
          expect(assigns(:story)).to eq(story)
        end
      end

      describe 'PATCH #update' do
        context 'valid data' do
          let(:valid_data) { attributes_for(:story, title: 'Brand new title') }
          before(:each) { patch :update, params: { id: story, story: valid_data } }

          it 'redirects to story#show' do
            expect(response).to redirect_to(story)
          end
          it 'updates record in database' do
            story.reload
            expect(story.title).to eq('Brand new title')
          end
        end

        context 'invalid_data' do
          let(:invalid_data) { attributes_for(:story, title: '',
                                              description: 'Brand new description'
                                             ) }
          before(:each) { patch :update, params: { id: story, story: invalid_data } }

          it 'renders :edit template' do
            expect(response).to render_template(:edit)
          end
          it 'does not update record in database' do
            story.reload
            expect(story.description).not_to eq('Brand new description')
          end
        end
      end

      describe 'DELETE #destroy' do
        let!(:story) { create(:story, user: user) }
        before(:each) { delete :destroy, params: { id: story } }

        it 'redirects to root page' do
          expect(response).to redirect_to(stories_path)
        end
        it 'deleted record from database' do
          expect(Story.exists?(story.id)).to be_falsy
        end
      end

      describe 'POST #subscribe' do
        it 'redirects to pundit path' do
          post :subscribe, params: { id: story }
          expect(response).to redirect_to(root_path)
        end
        it 'does not changes database' do
          post :subscribe, params: { id: story }
          expect(story.subscribers).not_to include(user)
        end
      end
    end

    context 'user does not own story' do
      let(:story) { create(:story) }

      context 'redirects to pundit path' do
        after(:each) { expect(response).to redirect_to(root_path) }
        it { get :edit, params: { id: story } }
        it { patch :update, params: { id: story, story: attributes_for(:story,
                                                                       title: 'Brand new title')} }
        it { delete :destroy, params: { id: story } }
      end

      context 'does not change database' do
        it 'PATCH #update' do
          patch :update, params: { id: story, story: attributes_for(:story,
                                                                    title: 'Brand new title')}
          story.reload
          expect(story.title).not_to eq('Brand new title')
        end
        it 'DELETE #destroy' do
          delete :destroy, params: { id: story }
          expect(Story.exists?(story.id)).to be_truthy
        end
      end

      describe 'POST #subscribe' do
        context 'user not subscribed' do
          it 'redirects to story' do
            post :subscribe, params: { id: story }
            expect(response).to redirect_to(story)
          end
          it 'changes database' do
            post :subscribe, params: { id: story }
            expect(story.subscribers).to include(user)
          end
        end

        context 'user already subscribed' do
          let(:story) { create(:story, subscribers: [user]) }

          it 'redirects to pundit path' do
            post :subscribe, params: { id: story }
            expect(response).to redirect_to(root_path)
          end
          it 'does not change database' do
            expect {
              post :subscribe, params: { id: story }
            }.not_to change(story.subscribers, :count)
          end
        end
      end

      describe 'DELETE #unsubscribe' do
        context 'subscribed users' do
          let(:story) { create(:story, subscribers: [user]) }
          it 'redirect to story' do
            delete :unsubscribe, params: { id: story }
            expect(response).to redirect_to(story)
          end
          it 'deletes subscription' do
            delete :unsubscribe, params: { id: story }
            story.reload
            expect(story.subscribers).not_to include(user)
          end
        end

        context 'unsubscribed users' do
          let(:story) { create(:story) }
          it 'redirects to pundit path' do
            delete :unsubscribe, params: { id: story }
            expect(response).to redirect_to(root_path)
          end
          it 'does not changes database' do
            expect {
              delete :unsubscribe, params: { id: story }
            }.not_to change(story.subscribers, :count)
          end
        end
      end
    end
  end
end
