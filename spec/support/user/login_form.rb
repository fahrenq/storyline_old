class LoginForm
  include Capybara::DSL

  def visit_page_direct
    visit('/login')
    self
  end

  # Test this case after final production design created.
  # def visit_page_click
  #   visit('/')
  #   click_on('Sign in')
  #   self
  # end

  def fill_in_fields(login_word, user, invalid = false)
    if login_word == 'email'
      fill_in('Login', with: user.email)
    elsif login_word == 'name'
      fill_in('Login', with: user.name)
    else
      raise ArgumentError, 'Wrong "login string" value. Only "email" or "name" allowed.'
    end
    password = if invalid
                 'wrong_password'
               else
                 user.password
               end
    fill_in('Password', with: password)
    self
  end

  def submit
    click_button('Log in')
    self
  end
end
