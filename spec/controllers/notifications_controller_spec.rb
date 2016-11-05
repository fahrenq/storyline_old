require 'rails_helper'

describe Web::NotificationsController, type: :controller do
  describe 'guest user' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { create(:user) }
    let(:notifications) { create_list(:notification, 5, users: [user]) }
    before { sign_in user }

    describe 'GET #index' do
      before(:each) { get :index }

      it { expect(response).to render_template(:index) }
      it { expect(assigns(:notifications)).to eq(notifications) }
    end
  end

end
