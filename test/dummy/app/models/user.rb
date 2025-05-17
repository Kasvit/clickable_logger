class User < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: { greater_than: 0 }

  def self.some_random_code
    x = User.last
    age = User.maximum(:age)
    age * 2 if age
  end
end
