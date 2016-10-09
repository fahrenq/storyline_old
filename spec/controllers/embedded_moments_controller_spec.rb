require 'rails_helper'

describe Web::Moments::NativeMomentsController, type: :controller do
  let(:embedded_moment_attributes) { { from: 'twitter',
                                       url: 'https://twitter.com/fahrenhei7lt/status/765376955697008640' } }

  describe 'guest user' do
    let(:story) { create(:story) }
    let(:embedded_moment) { create(:embedded_moment) }

    context 'redirects to login page' do
      after(:each) { expect(response).to redirect_to(new_user_session_url) }
      it { get :new, params: { story_id: story } }
      it { post :create, params: { story_id: story,
                                   embedded_moment: embedded_moment_source } }
      it { delete :destroy, params: { id: embedded_moment } }
    end
    context 'does not touch database' do
      it 'POST #create' do
        expect {
          post :create, params: { story_id: story,
                                  embedded_moment: embedded_moment_source }
        }.not_to change(EmbeddedMoment, :count)
      end
      it 'DELETE #destroy' do
        post :destroy, params: { id: embedded_moment }
        expect(EmbeddedMoment.exists?(embedded_moment.id)).to be_truthy
      end
    end
  end
end

describe 'authenticated user' do
  let(:user) { create(:user) }
  before { sign_in(user) }

  context "is not the owner of embedded_moment's story" do
    let(:user_2) { create(:user) }
    let(:story) { create(:story, user: user_2) }
    let(:embedded_moment) { create(:embedded_moment, story: story) }

    context 'redirects to pundit path' do
      after(:each) { expect(response).to redirect_to(root_path) }

      it { get :new, params: { story_id: story } }
      it { post :create, params: { story_id: story, embedded_from: 'twitter',
                                   embedded_moment: embedded_moment_source } }
      it { delete :destroy, params: { id: embedded_moment } }
    end
    context 'does not touch database' do
      it 'POST #create' do
        expect {
          post :create, params: { story_id: story, embedded_from: 'twitter',
                                  embedded_moment: embedded_moment_source }
        }.not_to change(EmbeddedMoment, :cont)
      end
      it 'DELETE #destroy' do
        post :destroy, params: { id: embedded_moment }
        expect(EmbeddedMoment.exists?(embedded_moment.id)).to be_truthy
      end
    end
  end
  context "is owner of embedded_moment's story" do
    let(:story) { create(:story, user: user) }
    let(:embedded_moment) { create(:embedded_moment, story: story) }

    describe 'GET #new' do
      before(:each) { get :new, params: { story_id: story } }

      it { expect(response).to render_template(:new) }
      it { expect(assigns(:native_moment)).to be_a_new(EmbeddedMoment) }
    end
    describe 'POST #create' do
      context 'valid_data' do
        it 'redirects to story#show' do
          post :create, params: { story_id: story,
                                  embedded_moment: embedded_moment_source }
          expect(response).to redirect_to(story)
        end
      end
      context 'invalid_data' do
        it 'renders :new template' do
          post :create, params: { story_id: story,
                                  embedded_moment: embedded_moment_source }
          expect(response).to render_template(:new)
        end
      end
      it 'sends request to service object' do
        create_embedded_moment = instance_double(CreateEmbeddedMoment)
        expect(CreateEmbeddedMoment).to receive(:new)
          .with(embedded_moment_source.megre(story_id: story))
        expect(create_embedded_moment).to receive(:call)
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
