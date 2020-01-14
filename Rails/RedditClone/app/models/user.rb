class User < ApplicationRecord
    validates :session_token, :password_digest, :username, presence: true
    validates :session_token, :username, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true, message: "password is too short, must be at least length 6!" }

    after_initialize :ensure_session_token
    
    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user if user && user.is_password?(password)
        nil

    end

    def self.generate_session_token
        session_token = SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)

    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end



end