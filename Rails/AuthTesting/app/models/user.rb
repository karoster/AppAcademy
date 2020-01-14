class User < ApplicationRecord
	validates :username, :session_token, presence: true, uniqueness: true
	validates :password_digest, length: {minimum: 6, allow_nil: true}
	validates :password_digest, presence: {message: "password can't be blank"}
	before_validation :ensure_session_token

	attr_reader :password

	def self.find_by_credentials(username, pass)
		user = User.where(username: username)
		return user if BCrypt_Password.new(user.password_digest).is_password?(pass)
		nil
	end

	def self.generate_session_token
		SecureRandom::urlsafe_base64(16)
	end

	def reset_session_token!
		self.session_token = User.generate_session_token
		self.save
		self.session_token
	end


	def ensure_session_token
		self.session_token ||= User.generate_session_token

	end


	def password=(pw)
		@password = pw
		self.password_digest = BCrypt_Password.create(pw)
	end

end
