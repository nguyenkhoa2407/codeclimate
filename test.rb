def create
  images = permitted_params[:booking_item][:images]
  booking_id = permitted_params[:booking_item][:booking_id]

  unless images.present? && booking_id.present?
    redirect_to new_admin_booking_item_path and return
  end

  saved_items_count = images.select do |image|
    BookingItem.create(
      booking_id: booking_id, 
      status: 'stored', 
      description: image.original_filename.split(".")[0], 
      image: image 
    ).persisted?
  end.count

  if saved_items_count > 0
    flash[:notice] = "Created #{saved_items_count} items successfully !"
    redirect_to collection_url
  end
end

def update
  update! and return unless params[:button] == "stored"

  # When the `Back to stored` button is clicked:
  $need_to_upload_image = permitted_params[:booking_item][:image].nil?

  if $need_to_upload_image
    flash.now[:alert] = "Please upload a new image then click 'Finish' to mark the item as back to stored"
    render "edit" and return
  end

  new_attributes = permitted_params[:booking_item].merge({
    status: "stored", 
    return_item_request_id: nil
  })

  booking_item = BookingItem.find(params[:id])
  redirect_to admin_booking_item_path(booking_item) if booking_item.update(new_attributes)
end