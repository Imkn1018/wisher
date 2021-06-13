class CompleteReviewsController < ApplicationController
  def new
    @wish = Wish.find(params[:wish_id])
    @review = CompleteReview.new
  end

  def create
    wish = Wish.find(params[:wish_id])
    @review = current_user.complete_reviews.new(review_params)
    @review.wish_id = wish.id
    @review.save
    redirect_to wish_path(wish)
  end

  private

  def review_params
    params.require(:complete_review).permit(:review_title,:review,:complete_image,:satisfy)
  end
end
