class Api::ItemsController < ApplicationController
  def update
    image = Image.where(item_id: params[:item_id].to_i)
    if image.length < 3
    @image = image.create(image: update_params, item_id: params[:item_id])
    respond_to do |format|
      format.html
      format.json
    end
    else
      render :edit
    end
  end

	def destroy
		image = Image.find(params[:id].to_i)
		image.destroy
	end

	private
	def update_params
	  params.require(:file)
	end
end
