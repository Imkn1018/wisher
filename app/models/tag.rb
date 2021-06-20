class Tag < ApplicationRecord
  has_many :wish_tag_relationships
  has_many :wishes, through: :wish_tag_relationships
  belongs_to :user
  # 各ユーザーは同じタグを持つことができないようにする
  validates :tag_name, presence: true, uniqueness: { scope: :user }

  attachment :image
end
