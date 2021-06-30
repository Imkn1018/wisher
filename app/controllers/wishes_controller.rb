class WishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @wish = current_user.wishes.new
  end

  def index
    user = User.find_by(id: current_user.id)
    @tag_list = user.tags.all
    
    #  タグ内の叶えたいこと一覧表示
    if params[:tag_id]

      @tag = Tag.find(params[:tag_id])
      @wishes = @tag.wishes.where(user_id: current_user.id).all
    # 通常の叶えたいこと一覧表示
    else
      @wishes = user.wishes.all
      @wish = current_user.wishes.where(user_id: current_user.id).new

    end
  end

  def create
    #   違うユーザーでやる場合はsave_tagの中のuserを適宜入れる
    @wish = current_user.wishes.build(wish_params)
    tag_list = params[:wish][:tag_name].split("、")
    if @wish.save
      # current_userをつけることでuser_id取得
      @wish.save_tag(tag_list, current_user)
      redirect_to wishes_path
    else
      flash[:failed] = 'タイトル、重要度は必須項目です'
      render :new

    end
  end

  def show
    user = User.find_by(id: current_user.id)
    @wish = Wish.find(params[:id])
    @wish_tags = @wish.tags
    @reviews = @wish.complete_reviews
    @review = CompleteReview.new
  end

  def edit
    @wish = Wish.find(params[:id])
    @tag_list = @wish.tags.pluck(:tag_name).join('、')
  end

  def update
    @wish = Wish.find(params[:id])
    tag_list = params[:wish][:tag_name].split("、")
    if @wish.update(wish_params)
      @wish.save_tag(tag_list, current_user)
      redirect_to wish_path(@wish)
    else
      flash[:failed] = 'タイトル、重要度は必須項目です'
      render :edit
    end
  end

  #   叶えたいこと削除
  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    redirect_to wishes_path
  end

  #  叶えたいこと =>　叶えたことリストに変更
  def complete
    @wish = Wish.find(params[:id])
    @wish.update(isCompleted: true)
    flash[:complete] = "Good life! 早速レビューを記録しよう！"
    redirect_to wish_path(@wish)
  end

  # 叶えたことリスト一覧表示
  def dones
    user = User.find_by(id: current_user.id)
    if params[:tag_id]
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @wishes = @tag.wishes.where(isCompleted: true)
    # 全ての表示
    else
      @wishes = user.wishes.where(isCompleted: true)
      @wish = current_user.wishes.new
      @tag_list = Tag.all
    end
  end

  # 叶えたことを叶えたいことに戻す
  def backWish
    @wish = Wish.find(params[:id])
    @wish.update(isCompleted: false)
    #   達成レビューを全て削除する
    @wish.complete_reviews.destroy_all
    redirect_to wish_path
  end

  # 叶えたことを叶えたいことに戻す前の確認画面の表示（達成レビューも全て削除するため）
  def confirm
    @wish = Wish.find(params[:id])
    @wish_tags = @wish.tags
  end

  def search
    @wishes = Wish.search(params[:keyword])
    @keyword = params[:keyword]
    @tag_list = Tag.all
    render 'index'
  end

  private

  def wish_params
    params.require(:wish).permit(:wish_title, :memo, :wish_image, :span, :importance, :url,:purpose, :action)
  end
end
