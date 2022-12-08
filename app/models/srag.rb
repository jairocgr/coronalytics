
require 'pathname'

class Srag < ApplicationRecord

  def local_path
    Rails.root.join('storage', "srag-#{id}.csv")
  end

  def file_name
    Pathname.new(url).basename
  end

end
