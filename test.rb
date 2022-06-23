def create
  images = permitted_params[:booking_item][:images]
  booking_id = permitted_params[:booking_item][:booking_id]

  unless images.present? && booking_id.present?
    redirect_to new_admin_booking_item_path and return
  end

  count_items_created_successfullly = 0

  images.each do |image|
    new_item = BookingItem.new({ 
      booking_id: booking_id, 
      status: 'stored', 
      description: item_description(image), 
      image: image 
    })
    count_items_created_successfullly += 1 if new_item.save
  end

  if count_items_created_successfullly > 0
    flash[:notice] = "Create #{count_items_created_successfullly} items successfully !"
    redirect_to collection_url
  end
end