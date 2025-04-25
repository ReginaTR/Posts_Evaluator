require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /posts" do
    let(:valid_params) do
      {
        login: "user_login",
        post: {
          title: "Post title",
          body: "Post body",
          ip: "192.168.0.1"
        }
      }
    end

    context "with valid params" do
      it "create a new post and a new user" do
        expect {
          post "/posts", params: valid_params
        }.to change(Post, :count).by(1)
         .and change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["user"]["login"]).to eq("user_login")
        expect(json["post"]["title"]).to eq("Post title")
      end

      it "create post only if user exists" do
        User.create!(login: "user_login")

        expect {
          post "/posts", params: valid_params
        }.to change(Post, :count).by(1)
         .and change(User, :count).by(0)
      end
    end

    context "with invalid params" do
      it "return error if title be blank" do
        invalid_params = valid_params.deep_merge(post: { title: "" })

        post "/posts", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Title can't be blank")
      end
    end
  end

end
