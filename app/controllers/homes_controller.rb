class HomesController < ApplicationController

  def top

      @wishes = Wish.all
      @reviews = CompleteReview.all
  end

  def guest_sign_in
    user = User.find_or_create_by!(name: 'guest1', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
