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

  def top_posts
    limit = params[:limit] || 10

    posts = Post
              .select("posts.id, posts.title, posts.body, AVG(ratings.value) as average_rating")
              .left_joins(:ratings)
              .group("posts.id")
              .order("average_rating DESC NULLS LAST")
              .limit(limit)

    render json: posts.as_json(only: [ :id, :title, :body ])
  end

  private

  def set_user
    @user = User.find_or_create_by(login: params[:login])
  end

  def post_params
    params.require(:post).permit(:title, :body, :ip)
  end
end
