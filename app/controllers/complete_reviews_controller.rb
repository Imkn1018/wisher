class CompleteReviewsController < ApplicationController
  def new
    @wish = Wish.find(params[:wish_id])
    @review = CompleteReview.new
  end
  def index
  end
  def create
    @wish = Wish.find(params[:wish_id])
    @review = current_user.complete_reviews.new(review_params)
    @review.wish_id = @wish.id
    @review.save
    redirect_to wish_path(wish)
  end

  def show
    @wish = Wish.find(params[:id])
    @review = CompleteReview.find_by(id: params[:id], wish_id: params[:wish_id])
  end

  def edit
    @wish = Wish.find(params[:wish_id])
    @review = CompleteReview.find_by(id: params[:id], wish_id: params[:wish_id])
  end

  def update
     @wish = Wish.find(params[:wish_id])
     @review = CompleteReview.find_by(id: params[:id], wish_id: params[:wish_id])
     if @review.update(review_params)
      redirect_to wish_complete_review_path(@wish, @review)
     else
       render :edit
     end
  end

  def destroy
  end
  private

  def review_params
    params.require(:complete_review).permit(:review_title,:review,:complete_image,:satisfy)
  end
end
