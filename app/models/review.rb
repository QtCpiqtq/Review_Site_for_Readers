class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :feeling_after_reading, optional: true
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  
  validates :evolution, presence: true
  validates :body, presence: true

  def good_by?(user)
    goods.exists?(user_id: user.id)
  end
  
  def body_size(size)
    if self.body.length > size
      self.body.truncate(size)
    else
      self.body
    end
  end
end
