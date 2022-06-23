def create
  images = permitted_params[:booking_item][:images]
  if !images || permitted_params[:booking_item][:booking_id].empty?
    redirect_to new_admin_booking_item_path
    return
  end

  @count_items_created_successfullly = 0

  images.each { |img|
    @custom_description = img.original_filename.split(".")[0]

    @item = BookingItem.new({ booking_id: permitted_params[:booking_item][:booking_id], status: "stored", description: @custom_description, image: img })

    if @item.save
      @count_items_created_successfullly += 1
    end
  }

  if @count_items_created_successfullly > 0
    flash[:notice] = "Create #{@count_items_created_successfullly} items successfully !"
    redirect_to collection_url
  end
end