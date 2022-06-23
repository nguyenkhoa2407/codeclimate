def update
  update! and return unless params[:button] == "stored"

  # When the `Back to stored` button is clicked:
  $need_to_upload_image = !permitted_params[:booking_item][:image].present?

  if $need_to_upload_image
    flash.now[:alert] = "Please upload a new image then click 'Finish' to mark the item as back to stored"
    render "edit" and return
  end

  new_attributes = permitted_params[:booking_item]
  new_attributes["status"] = "stored"
  new_attributes["return_item_request_id"] = nil

  booking_item = BookingItem.find(params[:id])
  redirect_to admin_booking_item_path(booking_item) if booking_item.update(new_attribuites)
end