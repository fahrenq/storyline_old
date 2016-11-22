require 'rails_helper'

describe Web::UsersController, type: :controller do
  describe 'avatar' do
    describe 'POST #change_avatar' do
      let(:avatar_1) { fixture_file_upload("#{Rails.root}/spec/fixtures/user_avatar.png", 'image/png') }
      let(:avatar_2) { fixture_file_upload("#{Rails.root}/spec/fixtures/user_avatar_2.jpg", 'image/jpg') }
      let(:bad_avatar) { fixture_file_upload("#{Rails.root}/spec/fixtures/user_avatar_bad.txt", 'text/plain') }
      context 'user is ok' do
        let(:user) { create(:user) }

        it 'adds avatar to user' do
          sign_in user
          patch :change_avatar, params: { avatar: avatar_1 }
          user.reload
          expect(user.avatar.original_filename).to eq(avatar_1.original_filename)
        end

        it 'updates avatar' do
          user = create(:user_with_avatar)
          sign_in user
          patch :change_avatar, params: { avatar: avatar_2 }
          user.reload
          expect(user.avatar.original_filename).not_to eq(avatar_1.original_filename)
          expect(user.avatar.original_filename).to eq(avatar_2.original_filename)
        end

        it 'redirects to edit_user_registration_path' do
          sign_in user
          patch :change_avatar, params: { avatar: avatar_1 }
          expect(response).to redirect_to(edit_user_registration_path)
        end
      end

      context 'user is a guest' do
        after(:each) { expect(response).to redirect_to(new_user_session_url) }

        it { patch :change_avatar, params: { avatar: avatar_1 } }
        it { delete :destroy_avatar }
      end

      context 'wrong file type' do
        let(:user) { create(:user) }
        before { sign_in user }

        it 'does not changes avatar' do
          patch :change_avatar, params: { avatar: bad_avatar }
          user.reload
          expect(user.avatar.original_filename).to be_nil
        end
        it 'renderects to edit' do
          sign_in user
          patch :change_avatar, params: { avatar: avatar_1 }
          expect(response).to redirect_to(edit_user_registration_path)
        end

      end
    end

    describe 'DELETE #destroy_avatar' do
      let(:user) { create(:user_with_avatar) }
      before { sign_in user }

      it 'deletes avatar' do
        delete :destroy_avatar
        user.reload
        expect(user.avatar.original_filename).to be_nil
      end
      it 'redirects to edit_user_registration_path' do
        delete :destroy_avatar
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end
  end
end
