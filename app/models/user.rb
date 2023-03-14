class User < ApplicationRecord
  attr_accessor :remember_token
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: /\A\S+@\S+\z/

    def self.authenticate(email, password)
        user = User.find_by(email: email)
        user && user.authenticate(password)
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end

    def remember 
      self.remember_token = user.new_token
      update_attribute(:remember_digest)
    end
end
