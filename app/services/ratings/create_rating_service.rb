module Ratings
  class CreateRatingService
    def initialize(post_id:, user_id:, value:)
      @post_id = post_id
      @user_id = user_id
      @value = value.to_i
    end

    def call
      post = Post.find_by(id: @post_id)
      user = User.find_by(id: @user_id)

      return { error: "Post or User not found" } if post.nil? || user.nil?

      if Rating.exists?(post_id: @post_id, user_id: @user_id)
        return { error: "User has already rated this post" }
      end

      rating = Rating.create(post: post, user: user, value: @value)

      average_rating = post.ratings.average(:value).to_f.round(1)

      { rating: rating, average_rating: average_rating }
    rescue ActiveRecord::RecordInvalid => e
      { error: e.message }
    end
  end
end
