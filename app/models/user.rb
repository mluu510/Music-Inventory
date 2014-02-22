# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  before_validation :set_session_token

  validates :email, :session_token, :password_digest, :presence => true
  # validates :password_digest, :presence => { :message => "Password can't be blank" }
  # validates :password, :length => { :minimum => 6, :allow_nil? => true }

  attr_reader :password

  def self.find_by_credentials(email, secret)
    user = User.find_by_email(email)
    user.is_password?(secret) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def set_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)

  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end
end
