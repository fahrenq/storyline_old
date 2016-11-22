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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :stories

  has_many :subscriptions
  has_many :sub_stories, through: :subscriptions, source: :story

  has_many :notification_recipients
  has_many :notifications, through: :notification_recipients

  validates :name,
            presence: true,
            uniqueness: {
              case_sensitive: false
            },
            format: {
              # this validation to avoid conflict between name and email
              # of different users due signing in.
              with: /\A[a-zA-Z0-9_\.]*\z/
            },
            length: { in: 2..28 }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/avatar_:style.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # let authenticate with login. with help of
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  # yes, rubocop warning this syntax, but for keep things simple and accorting
  # to official code - let's leave from refactoring.
  attr_accessor :login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(name) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
