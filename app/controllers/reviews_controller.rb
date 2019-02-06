class ReviewsController < ApplicationController

  before_action :set_item

  def new
    @review = Review.new
  end

  def create
    Review.create(review_params)
    @item[:trade] = "売却済"
    @item.save
    redirect_to :root, notice: "Thank you!"
  end

  private
  def review_params
    if @item.seller_id == current_user.id
      params.require(:review).permit(:review).merge(giver_id: current_user.id,taker_id: @item.buyer_id)
    else
      params.require(:review).permit(:review).merge(giver_id: current_user.id,taker_id: @item.seller_id)
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
