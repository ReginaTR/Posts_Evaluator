class PostsController < ApplicationController
  before_action :set_user


  def create
    @post = @user.posts.new(post_params)

    if @post.save
      render json: { user: @user, post: @post }, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_or_create_by(login: params[:login])
  end

  def post_params
    params.require(:post).permit(:title, :body, :ip)
  end
end
