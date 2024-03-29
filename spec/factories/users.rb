# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "UserName#{n}" }
    sequence(:email) { |n| "samplemail_#{n}@example.com" }
    password 'pswd1234'
    confirmed_at Time.now

    factory :user_with_avatar do
      avatar { fixture_file_upload("#{Rails.root}/spec/fixtures/user_avatar.png", 'image/png') }
    end

    factory :unconfirmed_user do
      confirmed_at nil
    end

    factory :user_faker do
      name Faker::Internet.user_name
      email Faker::Internet.email
    end
  end
end
