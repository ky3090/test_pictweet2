class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :show, :update]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comment.includes(:user)
  end

  def edit
  end

  def update
    @tweet.update(tweet_params)
  end

  def destroy
    @tweet.destroy
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end
