
class Admin::Credential
  include ActiveModel::API
  include ActiveModel::Validations
  attr_accessor :login, :password
  validates :login, presence: true
  validates :password, presence: true
end
