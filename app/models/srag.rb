class Srag < ApplicationRecord

  def local_path
    Rails.root.join('storage', "srag-#{id}.csv")
  end

end
