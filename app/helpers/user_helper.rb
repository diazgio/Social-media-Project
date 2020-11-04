module UserHelper
  # rubocop: disable Style/GuardClause, Layout/LineLength
  def add_friend(user) 
    if current_user.id == user.id || current_user.friend?(user)
      nil
    elsif pending_id(current_user).find { |x| x == user.id }
      link_to 'Cancel Invitation', reject_path(user_id: current_user.id, friend_id: user.id),
              class: 'btn btn-danger', method: :delete
    else
      link_to 'Add friend', user_friendships_path(user), method: :post, class: 'btn btn-success'
    end
  end

  def pending_id(user)
    @ids = []
    user.pending_friends.each do |people|
      @ids << people.id
    end
    @ids << current_user.id
  end

  def not_a_friend(user_id)
    if current_user.id == @user.id
      link_to 'Unfriend', reject_path(user_id: current_user.id, friend_id: user_id),  method: :delete, class: 'btn btn-danger'
    end
  end

  def your_friends(user)
    return if user.friends.nil?
    content_tag (:div) do
      user.friends.each do |people|
        concat link_to (
          content_tag (:li) do
            content_tag (:p) do
              ("#{link_to people.name, user_path(people.id), class: 'mx-2'}" +
              "#{not_a_friend(people.id)}").html_safe
            end
          end
        )
      end
    end
  end
  # rubocop: enable Style/GuardClause, Layout/LineLength
end
