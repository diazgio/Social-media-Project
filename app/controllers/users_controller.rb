class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @mutual_friends = User.where(id: show_three_friends)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  private

  def show_mutual_friends
    @ids = []
    current_user.friends.each do |peolpe|
      people.friends.each do |x|
        @ids << x.id
      end
    end
    @ids.reject { |x| x == current_user.id}
  end

  def show_three_friends
    show_mutual_friends.sample(3)
  end
end
