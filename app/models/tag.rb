class Tag < ApplicationRecord
  has_many :wish_tag_relationships
  has_many :wishes, through: :wish_tag_relationships


  attachment :image
end
