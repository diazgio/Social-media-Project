module UserHelper
  # rubocop: disable Style/GuardClause, Layout/LineLength, Style/RedundantParentheses, Lint/ParenthesesAsGroupedExpression
  def add_friend(user)
    current_user.friend_requests.each do |people|
      @friendsi =  people.id
    end
    if current_user.id == user.id || current_user.friend?(user)
      nil
    elsif pending_id(current_user).find { |x| x == user.id }
      link_to 'Cancel Invitation', reject_path(user_id: current_user.id, friend_id: user.id),
      class: 'btn btn-danger', method: :delete
    elsif @friendsi == user.id
      ("#{link_to 'Accept Invitation', accept_path(user_id: user.id, friend_id: current_user.id), class: 'btn btn-success mx-2', method: :post}" \
        "#{link_to 'Reject Invitation', reject_path(user_id: user.id, friend_id: current_user.id), class: 'btn btn-danger mx-2', method: :delete}").html_safe
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
      link_to 'Unfriend', reject_path(user_id: current_user.id, friend_id: user_id), method: :delete, class: 'btn btn-danger'
    end
  end

  def your_friends(user)
    return if user.friends.nil?

    content_tag :div do
      user.friends.each do |people|
        concat link_to (
          content_tag :li do
            content_tag :p do
              ("#{link_to people.name, user_path(people.id), class: 'mx-2'}" \
              "#{not_a_friend(people.id)}").html_safe
            end
          end
        )
      end
    end
  end

  def pending_requests(user)
    if user.id == @user.id
      return if user.friends.nil?

      content_tag :div do
        user.pending_friends.each do |people|
          concat link_to (
            content_tag :li do
              content_tag :p do
                link_to people.name, user_path(people.id)
              end
            end
          )
        end
      end
    end
  end

  def friendships_requests(user)
    return if user.friends.nil?

    content_tag :div do
      user.friend_requests.each do |people|
        concat link_to (
          content_tag :li do
            content_tag :p do
              ("#{link_to people.name, user_path(people.id), class: 'mx-2'}" \
                "#{link_to 'Accept Invitation', accept_path(user_id: people.id, friend_id: current_user.id), class: 'btn btn-success mx-2', method: :post}" \
                "#{link_to 'Reject Invitation', reject_path(user_id: people.id, friend_id: current_user.id), class: 'btn btn-danger mx-2', method: :delete}").html_safe
            end
          end
        )
      end
    end
  end
  # rubocop: enable Style/GuardClause, Layout/LineLength, Style/RedundantParentheses, Lint/ParenthesesAsGroupedExpression
end
