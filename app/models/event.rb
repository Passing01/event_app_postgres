class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances, source: :user
  

  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, multiple_of: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }
  validates :location, presence: true
  #def is_free?
  #  price == 0
  #end

  belongs_to :user

  validates :start_date, presence: true
  validates :duration, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :location, presence: true


end
