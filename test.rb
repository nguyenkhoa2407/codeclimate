def create
  images = permitted_params[:booking_item][:images]
  booking_id = permitted_params[:booking_item][:booking_id]

  unless images.present? && booking_id.present?
    redirect_to new_admin_booking_item_path and return
  end

  saved_item_count = images.select do |image|
    BookingItem.create(
      booking_id: booking_id, 
      status: 'stored', 
      description: image.original_filename.split(".")[0], 
      image: image 
    ).persisted?
  end.count

  if saved_item_count > 0
    flash[:notice] = "Created #{saved_item_count} items successfully !"
    redirect_to collection_url
  end
end