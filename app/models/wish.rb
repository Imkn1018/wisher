class Wish < ApplicationRecord
  has_many :complete_reviews
  has_many :wish_tag_relationships, dependent: :destroy
  has_many :tags, through: :wish_tag_relationships
  belongs_to :user, required: true

  def self.search(keyword)
    where(['wish_title like? OR purpose like? OR memo like?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
  attachment :wish_image
  # タグ付機能
  def save_tag(tags, current_user)
    # タグテーブルのtag_nameカラムの一覧を取り出す
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 既存のタグの配列から配列を除外
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      new_tag.user = current_user
      self.tags << new_tag
    end
  end
  # レビュー機能
  validates :importance, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  validates :wish_title, presence: true

end
