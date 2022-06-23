def update
  update! and return unless params[:button] == "stored"

  # When the `Back to stored` button is clicked:
  booking_item = BookingItem.find(params[:id])

  $need_to_upload_image = !permitted_params[:booking_item][:image].present?

  if $need_to_upload_image
    flash.now[:alert] = "Please upload a new image then click 'Finish' to mark the item as back to stored"
    render "edit" and return
  end

  booking_item.attributes = permitted_params[:booking_item]
  booking_item.status = "stored"
  booking_item.return_item_request_id = nil

  if booking_item.save
    redirect_to admin_booking_item_path(booking_item)
  end
end