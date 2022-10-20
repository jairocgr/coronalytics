
class Admin::UserFilter
  include ActiveModel::API

  attr_accessor :name, :email

  def empty?
    name.blank? and email.blank?
  end

  def search_params
    params = []

    unless name.blank? then
      params.push "name <mark>\"#{name}\"</mark>"
    end
    unless email.blank? then
      params.push "email <mark>\"#{email}\"</mark>"
    end

    return params.join(", ").html_safe
  end
end
