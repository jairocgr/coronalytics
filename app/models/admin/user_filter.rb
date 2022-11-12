
class Admin::UserFilter
  include ActiveModel::API

  attr_accessor :name, :email

  def empty?
    name.blank? and email.blank?
  end

  def search_params
    params = []

    unless name.blank? then
      attr_name = self.class.human_attribute_name(:name).downcase
      params.push "#{attr_name} <mark>\"#{name}\"</mark>"
    end

    unless email.blank? then
      attr_name = self.class.human_attribute_name(:email).downcase
      params.push "#{attr_name} <mark>\"#{email}\"</mark>"
    end

    return params.join(", ").html_safe
  end
end
