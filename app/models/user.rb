class User < ActiveRecord::Base
  has_secure_password


  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password, length: {minimum: 5}
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  before_save { self.email.downcase!}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
