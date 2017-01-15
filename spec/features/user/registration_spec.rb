require 'rails_helper'
require_relative '../../support/user/registration_form'

feature 'Registration with email' do
  let(:registration_form) { RegistrationForm.new }
  let(:success_content_regexp) do
    Regexp.new([I18n.t('devise.registrations.signed_up'),
                I18n.t('devise.registrations.signed_up_but_inactive'),
                # I18n.t('devise.registrations.signed_up_but_locked'),
                I18n.t('devise.registrations.signed_up_but_unconfirmed')]
      .join('|'))
  end

  before { logout }

  scenario 'registration with valid data' do
    registration_form.visit_page_direct
                     .fill_in_with
                     .submit
    expect(page).to have_content(success_content_regexp)
  end

  scenario 'registration with invalid data' do
    registration_form.visit_page_direct
                     .fill_in_with(name: '')
                     .submit
    expect(page).not_to have_content(success_content_regexp)
  end

  describe 'confirmation email' do
    let(:user_email) { 'abcd@gmail.com' }
    before :each do
      registration_form.visit_page_direct
                       .fill_in_with(email: user_email)
                       .submit
    end

    context 'confirmation email sent and text' do
      # Include email_spec modules here, not in rails_helper because they
      # conflict with the capybara-email#open_email method which lets us
      # call current_email.click_link below.
      # Re: https://github.com/dockyard/capybara-email/issues/34#issuecomment-49528389
      include EmailSpec::Helpers
      include EmailSpec::Matchers

      # open the most recent email sent to user_email
      subject { open_email(user_email) }

      # Verify email details
      it { is_expected.to deliver_to(user_email) }
      it { is_expected.to have_body_text(/You can confirm your account/) }
      it { is_expected.to have_subject(/Confirmation instructions/) }
    end

    context 'when clicking confirmation link in email' do
      before :each do
        open_email(user_email)
        current_email.click_link 'Confirm my account'
      end

      it 'shows confirmation message' do
        expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))
      end
      it 'confirms user' do
        user = User.find_for_authentication(email: user_email)
        expect(user).to be_confirmed
      end
    end # context end
  end
end
