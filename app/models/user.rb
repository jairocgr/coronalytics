class User < ApplicationRecord

  scope :non_deleted, -> { where(deleted: false) }
  scope :pending_activation, -> { where(active: false) }
  scope :allowed_to_login, -> { non_deleted.where(active: true) }

  validates :name, presence: true, length: { in: 2..256 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: VALID_EMAIL_REGEX }

  has_secure_password validations: false

  # Password must be at leas 4 char long (only if present)
  validates :password, length: { in: 4..128 }, if: -> { password.present? }
  validates :password, confirmation: true

  before_create :set_activation_token

  def root?
    id == 1
  end

  def activate!
    update! active: true, activation_date: DateTime.now
  end
  
  def allowed_to_access?
    active? and not deleted?
  end

  def self.filter(filter)
    if filter.name.present? then
      name_like = where("name like ?", "%#{filter.name}%")
    else
      name_like = where('TRUE')
    end

    if filter.email.present? then
      email_like = where("email like ?", "%#{filter.email}%")
    else
      email_like = where('TRUE')
    end

    return name_like.and(email_like)
  end

  def self.auth(credential)
    user = User.allowed_to_login.find_by(email: credential.login)
    if user.present?
      if user.authenticate credential.password then
        return user
      end
    end

    return nil
  end

private

  def set_activation_token
    self.activation_token = gen_token
  end

  def gen_token
    SecureRandom.alphanumeric(16).upcase
  end

end
