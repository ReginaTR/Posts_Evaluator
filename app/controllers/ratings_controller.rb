class RatingsController < ApplicationController
  def create
    service = Ratings::CreateRatingService.new(
      post_id: params[:rating][:post_id],
      user_id: params[:rating][:user_id],
      value: params[:rating][:value]
    )

    result = service.call

    if result[:error]
      render json: { error: result[:error] }, status: :unprocessable_entity
    else
      render json: {
        message: "Rating created successfully",
        rating: {
          id: result[:rating].id,
          value: result[:rating].value
        },
        average_rating: result[:average_rating]
      }, status: :created
    end
  end
end
