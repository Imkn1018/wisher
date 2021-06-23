class CompleteReviewsController < ApplicationController
  protect_from_forgery :except => [:create,:update,:destroy]
  def new
    @wish = Wish.find(params[:wish_id])
    @review = CompleteReview.new
  end
  def index
     @wish = Wish.find(params[:wish_id])
    reviews = @wish.complete_reviews
    render json: reviews
  end
  def create
    wish = Wish.find(params[:wish_id])
    @review = current_user.complete_reviews.new(review_params)
    @review.wish_id = wish.id
    @review.save
    if @review = @review[0]
      redirect_to wish_path(wish)
    end
    if wish.isCompleted = false
      wish.update(isCompleted => true)
    end
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
     review = CompleteReview.find_by(id: params[:id], wish_id: params[:wish_id])
     if review.update(review_params)
        render json: review
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
