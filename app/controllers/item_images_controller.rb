class ItemImagesController < ApplicationController

  def destroy
    @image = ItemImage.find(params[:id])
    if @image.destroy
      redirect_to edit_item_path(@image.item_id)
    end
  end

end
