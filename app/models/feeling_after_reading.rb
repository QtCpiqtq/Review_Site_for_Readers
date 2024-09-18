class FeelingAfterReading < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
