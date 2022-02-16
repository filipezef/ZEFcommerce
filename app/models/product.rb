class Product < ApplicationRecord
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 }
  validates :description, presence: true,
                          uniqueness: { case_sensitive: false },
                          length: { minimum: 20, maximum: 2000 }
  validates :value, presence: true, numericality: true
end