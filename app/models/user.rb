class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wishes, dependent: :destroy
  has_many :complete_reviews, dependent: :destroy
  has_many :tags, dependent: :destroy

  attachment :image
  validates :name, presence: true
  # ゲストログイン機能
  def self.guest
    find_or_create_by!(name: 'guest1', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end
end
