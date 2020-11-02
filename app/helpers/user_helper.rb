module UserHelper
  def add_friend(user)
    if current_user == user.id
      nil
    else
      link_to 'Add friend', user_friendships_path(user), method: :post
    end
  end
end
