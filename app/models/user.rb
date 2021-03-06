class User < ActiveRecord::Base
	# 11.10 To get code like user.micropost to work (method associations)
	has_many :microposts, dependent: :destroy # 11.18: Ensuring that a user’s microposts are destroyed along with the user
	# 12.2: Implementing the active relationships has_many association
	has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
	# 12.12: Implementing user.followers using passive relationships
	has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower # 12.12: Implementing user.followers using passive relationships

  has_many :following, through: :active_relationships, source: :followed # 12.8: Adding the User model following association


  attr_accessor :remember_token, :activation_token, :reset_token #10.42 reset_token
  before_save :downcase_email # before save call back automatically called before save
	before_create :create_activation_digest # 10.3 before creating call 
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true #allows password to be nil on update method (works becuase new user sign up method has_secure_pass	 word requires a password)

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

	# 10.24 Returns true if the given token matches the digest. A generalized authenticated? method
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end	

  # 10.33 Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 10.33 Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

	# Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

	# Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
	
	# 10.53 Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

	# 11.44
	# Defines a proto-feed.
  # See "Following users" for the full implementation.
  def feed
		# 12.45: Using key-value pairs in the feed’s where method
		# 12.46 The final implementation of the feed.
		following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
		# where method on the Micropost model. Also, escaping id attribute in this SQL statement is a good habit to get into
  	# 12.42 the initial working feed ^ 
	end

	# 12.10 Utility methods for following (associative methods)
  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end



	private
	
		# 10.3 Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

		# 10.3 Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
