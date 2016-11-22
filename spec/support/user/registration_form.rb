class RegistrationForm
  include Capybara::DSL

  AVATAR_FILENAME = 'user_avatar.png'
  AVATAR_PATH = "#{Rails.root}/spec/fixtures/#{AVATAR_FILENAME}"

  def visit_page_direct
    visit('/registration')
    self
  end

  # Test this case after final production design created.
  # def visit_page_click
  #   visit('/')
  #   click_on('Registration')
  #   self
  # end

  def fill_in_with(params = {})
    password = Faker::Internet.password(8)
    fill_in('Name', with: params.fetch(:name, Faker::Internet.user_name))
    fill_in('Email', with: params.fetch(:email, Faker::Internet.email))
    attach_file('Avatar', params.fetch(:avatar, AVATAR_PATH))
    fill_in('Password', with: params.fetch(:password, password), match: :prefer_exact)
    fill_in('Password confirmation', with: params.fetch(:password_confirmation, password), match: :prefer_exact)
    self
  end

  def submit
    click_button('Sign up')
    self
  end
end
