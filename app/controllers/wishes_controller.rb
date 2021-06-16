class WishesController < ApplicationController
  before_action :authenticate_user!
  def new
    @wish = current_user.wishes.new
  end
  def index
     user = User.find_by(id: current_user.id)
    #  タグ内の叶えたいこと一覧表示
     if params[:tag_id]
       @tag_list = Tag.all
        @tag = Tag.find(params[:tag_id])
        @wishes = @tag.wishes.where(:isCompleted => false)
    # 通常の叶えたいこと一覧表示
     else
         @wishes = user.wishes.where(:isCompleted => false)
         @wish = current_user.wishes.new
         @tag_list = Tag.all
     end

  end
  def create
    @wish = current_user.wishes.new(wish_params)
    tag_list = params[:wish][:tag_name].split(nil)
    if @wish.save
      @wish.save_tag(tag_list)
      redirect_to wishes_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @wish = Wish.find(params[:id])
    @wish_tags = @wish.tags
    @review = CompleteReview.new
  end

  def edit
    @wish = Wish.find(params[:id])
    @tag_list = @wish.tags.pluck(:tag_name).join(nil)
  end

  def update
    @wish = Wish.find(params[:id])
    tag_list = params[:wish][:tag_name].split(nil)
    if @wish.save
      @wish.save_tag(tag_list)
      redirect_to wish_path(@wish)
    else
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
      redirect_to new_wish_complete_review_path(@wish)
    end
    # 叶えたことリスト一覧表示
   def dones
     user = User.find_by(id: current_user.id)
     if params[:tag_id]
       @tag_list = Tag.all
        @tag = Tag.find(params[:tag_id])
        @wishes = @tag.wishes.where(:isCompleted => true)
    # 全ての表示
     else
       @wishes = user.wishes.where(:isCompleted => true)
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
      redirect_to wishes_path
   end

# 叶えたことを叶えたいことに戻す前の確認画面の表示（達成レビューも全て削除するため）
   def confirm
       @wish = Wish.find(params[:id])
       @wish_tags = @wish.tags
   end
      private

      def wish_params
        params.require(:wish).permit(:wish_title,:memo,:wish_image,:span,:difficulty,:url)
      end
end
