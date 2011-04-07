module CommentsHelper
  def get_availlable_message_box_list

    array=[]

    message_boxes=MessageBox.all
    message_boxes.each do |box|
    array<<[box.description , box.id]

    end
    array
  end
end
