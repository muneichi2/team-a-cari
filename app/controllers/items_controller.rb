class ItemsController < ApplicationController

  def index

    @categories = Category.all

    ladies_category = Category.find(1)
    ladies = Category.descendants_of ladies_category
    @ladies_items = Item.includes(:item_images).where(category_id: ladies.ids).order("created_at DESC").limit(Image_count)

    mens_category = Category.find(2)
    mens = Category.descendants_of mens_category
    @mens_items = Item.includes(:item_images).where(category_id: mens.ids).order("created_at DESC").limit(Image_count)

    kids_category = Category.find(3)
    kids = Category.descendants_of kids_category
    @kids_items = Item.includes(:item_images).where(category_id: kids.ids).order("created_at DESC").limit(Image_count)

    @chanel_items = Item.includes(:item_images).where(brand_id: 1).order("created_at DESC").limit(Image_count)
    @lui_items = Item.includes(:item_images).where(brand_id: 3).order("created_at DESC").limit(Image_count)
    @sup_items = Item.includes(:item_images).where(brand_id:4).order("created_at DESC").limit(Image_count)
    @nike_items = Item.includes(:item_images).where(brand_id: 2).order("created_at DESC").limit(Image_count)

  end

  def trade_sell
    @items = Item.where(trade:"出品中").where(seller_id: current_user.id)
  end

  def trade_now
    @items = Item.where(trade:"取引中").where(seller_id: current_user.id)
  end

  def trade_sold
    @items = Item.where(trade:"売却済").where(seller_id: current_user.id)
  end

  def buy_now
    @items = Item.where(trade:"取引中").where(buyer_id: current_user.id)
  end

  def bought
    @items = Item.where(trade:"売却済").where(buyer_id: current_user.id)
  end

  def new
    @item = Item.new
    @item.item_images.build

    respond_to do |format|
      format.html
      format.json { @children = Category.children_of(params[:parent_id]) }
    end
  end

  def create
    @item = Item.new(create_params)
    if @item.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    @item_images = @item.item_images.limit(Image_count)
    @user = User.find(@item.seller_id)
    @reviews = Review.where(taker_id: @user.id)
    @good_reviews = @reviews.where(review: "良い")
    @normal_reviews = @reviews.where(review: "普通")
    @bad_reviews = @reviews.where(review: "悪い")
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def change
    @item = Item.find(params[:id])
    @item_images = @item.item_images.limit(Image_count)
  end

  def edit
    @item = Item.find(params[:id])
    @set_sub = @item.category.parent
    @set_third = @item.category
    @sub_categories = Category.siblings_of(@item.category.parent)
    @third_categories = Category.siblings_of(@item.category)

    @commission = (@item.price * Commission).floor
    @profit = @item.price - @commission
  end

  def update
    item = Item.find(params[:id])
    if current_user.id == item.seller_id && user_signed_in?
      item.update(update_params)
      redirect_to action: 'change'
    else
      redirect_to action: 'edit'
    end
  end

  def search
    @search = Item.includes(:user).ransack(params[:q])
    @items = @search.result(distinct: true)
  end

  def change
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.seller_id == current_user.id
    redirect_to "/users/#{current_user.id}/trade/sell"
  end

  private
  def create_params
    params.require(:item).permit(:name, :price, :describe, :size_id, :brand_id, :status, :burden, :delivery_method, :prefecture, :delivery_day, :category_id, item_images_attributes: [:image]).merge(seller_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :price, :describe, :size_id, :brand_id, :status, :burden, :delivery_method, :prefecture, :delivery_day, :category_id, item_images_attributes: [:id , :item_id, :image, :_destroy]).merge(seller_id: current_user.id)
  end

end
