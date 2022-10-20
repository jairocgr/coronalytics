class User < ApplicationRecord

  validates :name, presence: true, length: { in: 2..256 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: VALID_EMAIL_REGEX }

  has_secure_password

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
end
