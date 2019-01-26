class ItemsController < ApplicationController

  def index
    @categories = Category.all

    ladies_category = Category.find(1)
    ladies = Category.descendants_of ladies_category
    @ladies_items = Item.includes(:item_images).where(category_id: ladies.ids).order("created_at DESC").limit(4)

    mens_category = Category.find(2)
    mens = Category.descendants_of mens_category
    @mens_items = Item.includes(:item_images).where(category_id: mens.ids).order("created_at DESC").limit(4)

    kids_category = Category.find(3)
    kids = Category.descendants_of kids_category
    @kids_items = Item.includes(:item_images).where(category_id: kids.ids).order("created_at DESC").limit(4)

    @chanel_items = Item.includes(:item_images).where(brand_id: 1).order("created_at DESC").limit(4)
    @lui_items = Item.includes(:item_images).where(brand_id: 3).order("created_at DESC").limit(4)
    @sup_items = Item.includes(:item_images).where(brand_id:4).order("created_at DESC").limit(4)
    @nike_items = Item.includes(:item_images).where(brand_id: 2).order("created_at DESC").limit(4)

  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def logout
  end

  def buy
  end

end
