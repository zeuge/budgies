class Budgie < ActiveRecord::Base
  validates :name, presence: true
  validates :color_id, presence: true
  validates :father_id, presence: true
  validates :mother_id, presence: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
