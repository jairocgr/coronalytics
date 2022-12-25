class AccessCode < ApplicationRecord
  validates :name, presence: true, length: { in: 2..128 }
  validates :code, presence: true, uniqueness: true, format: { with: /\A[0-9A-Z]+\z/i }

  scope :actives, -> { where(active: true) }
  
  def count_access()
    increment! :access_counter
  end
end
