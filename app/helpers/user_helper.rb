module UserHelper
  def add_friend(user)
    if current_user.id == user.id
      nil
    elsif pending_id(current_user).find{ |x| x == user.id }
      link_to 'Cancel Invitation', reject_path(user_id: current_user.id, friend_id: user.id),
              class: 'btn btn-danger col', method: :delete
    else
      link_to 'Add friend', user_friendships_path(user), method: :post, class:'btn btn-success'
    end
  end

  def pending_id(user)
    @ids = []
    user.pending_friends.each do |people|
      @ids << people.id
    end
    @ids << current_user.id
  end

  def not_a_friend
    if current_user.id == @user.id
      link_to 'Unfriend', reject_path(user_id: @user.id, friend_id: current_user.id), class: 'btn btn-danger', method: :delete
    end
  end
end
