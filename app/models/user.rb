 class User < ActiveRecord::Base

    has_secure_password

    validates :name, presence: true
    validates :email, presence: true
    validates_length_of :password, minimum: 6

    def self.authenticate_with_credentials(email, password)
        user = User.where('lower(email) = ?', email.downcase.strip).first
        if user && user.authenticate(password)
            return user
        else
            return nil
        end
    end
end
