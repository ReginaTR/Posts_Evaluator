require 'rails_helper'

RSpec.describe "Ratings", type: :request do
  let!(:blog_post) { create(:post) }
  let!(:user) { create(:user) }

  describe "POST /ratings" do
    context "when the user rates the post successfully" do
      it "creates a rating successfully" do
        post '/ratings', params: { rating: { post_id: blog_post.id, user_id: user.id, value: 5 } }

        expect(response).to have_http_status(:created)
        expect(json["message"]).to eq("Rating created successfully")
        expect(Rating.count).to eq(1)
        expect(Rating.last.value).to eq(5)
      end
    end

    context "when the same user tries to rate the same post twice" do
      it "does not allow the same user to rate the same post twice" do
        create(:rating, post: blog_post, user: user)

        post '/ratings', params: { rating: { post_id: blog_post.id, user_id: user.id, value: 4 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["error"]).to eq("User has already rated this post")
      end
    end

    context "when calculating the average rating with multiple users" do
      it "calculates the average rating correctly" do
        create(:rating, post: blog_post, user: user, value: 5)
        other_user = create(:user, login: "other_user")
        create(:rating, post: blog_post, user: other_user, value: 3)

        third_user = create(:user, login: "third_user")
        post '/ratings', params: { rating: { post_id: blog_post.id, user_id: third_user.id, value: 2 } }

        expect(response).to have_http_status(:created)

        expect(json["average_rating"]).to eq(3.3)
      end
    end
  end
end
