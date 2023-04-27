class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true

  scope :id_ordered_desc, -> { order(id: :desc) }
end
