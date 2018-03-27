class EpicenterController < ApplicationController

before_action :authenticate_user!
before_action :set_user, only: [:show_user, :following, :followers]

  def feed
    user_ids = current_user.following + [current_user.id]
    @following_tweets = Tweet.where(user_id: user_ids).order(created_at: :desc)
    @tweet = Tweet.new
    most_tweets_user_id = Tweet.all.group(:user_id).count.max_by {|k,v| v}.first
    @most_tweets_user = User.find(most_tweets_user_id)
    top_3_tag_ids = TweetTag.all.group(:tag_id).order('count(*) desc').limit(3).pluck(:tag_id)
    @top_tags = Tag.where(id: top_3_tag_ids)
  end

  def show_user
    user_ids = current_user.following + [current_user.id]
    @following_tweets = Tweet.where(user_id: user_ids).order(created_at: :desc)
    @tweet = Tweet.new
  end

  def now_following
    current_user.update(following: current_user.following << params[:id].to_i)
    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save!
    redirect_to show_user_path(id: params[:id])
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.order(:username)
  end

  def following
    @users = User.where(id: @user.following)
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
