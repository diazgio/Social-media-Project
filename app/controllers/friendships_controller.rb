class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[create accept reject destroy]

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: 'Friendship request was sented.'
    else
      redirect_to users_path, alert: @friendship.errors.full_messages.join('. ').to_s
    end
  end

  def accept
    @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
    @friendship.update confirmed: true
    redirect_to users_path, notice: 'Friendship was accepted'
  end

  def reject
    @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
    #@friendship = Friendship.find_by(friend_id: params[:user_id], user_id: params[:friend_id]) if @friendship.nil?
    @friendship.destroy
    redirect_to users_path, notice: 'Friendship was rejected'
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy

    redirect_to users_path, notice: 'Friend removed!'
  end
end
