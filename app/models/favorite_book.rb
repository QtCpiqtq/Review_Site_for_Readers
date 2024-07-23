class FavoriteBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  before_validation :check_count
  
  private
  
  def check_count
    count = FavoriteBook.where(user_id: self.user_id).size
    if count >= 3
      self.errors.add(:base, "すでにお気に入りの3冊は登録されています。")
    end
  end
end
