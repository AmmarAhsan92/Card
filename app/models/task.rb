class Task < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence: true

  scope :id_ordered_desc, -> { order(id: :desc) }
end
