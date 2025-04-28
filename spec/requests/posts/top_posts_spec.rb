require 'rails_helper'

RSpec.describe "Posts", type: :request do
    describe "GET /posts/top_posts" do
        let!(:user) { create(:user) }
        let!(:post1) { create(:post, user: user, title: "First Post") }
        let!(:post2) { create(:post, user: user, title: "Second Post") }

        before do
          create(:rating, post: post1, value: 5)
          create(:rating, post: post2, value: 3)
        end

        it "returns the top posts ordered by average rating" do
          get "/posts/top_posts"

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json.size).to eq(2)
          expect(json.first["id"]).to eq(post1.id)
          expect(json.second["id"]).to eq(post2.id)
        end

        it "limits the number of posts if limit param is given" do
          get "/posts/top_posts", params: { limit: 1 }

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)
          expect(json.size).to eq(1)
          expect(json.first["id"]).to eq(post1.id)
        end
    end
end