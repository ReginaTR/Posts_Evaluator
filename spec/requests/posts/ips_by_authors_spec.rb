require 'rails_helper'

RSpec.describe "Posts", type: :request do
    describe "GET /posts/ips_by_authors" do
        let!(:user1) { create(:user, login: "user1") }
        let!(:user2) { create(:user, login: "user2") }
        let!(:user3) { create(:user, login: "user3") }

        let!(:post1) { create(:post, user: user1, ip: "192.168.1.1") }
        let!(:post2) { create(:post, user: user2, ip: "192.168.1.1") }
        let!(:post3) { create(:post, user: user3, ip: "10.0.0.1") }
        let!(:post4) { create(:post, user: user1, ip: "10.0.0.1") }

        it "returns a list of IPs with associated user logins" do
          get "/posts/ips_by_authors"

          expect(response).to have_http_status(:success)

          json = JSON.parse(response.body)

          expect(json).to include(
            a_hash_including(
              "ip" => "192.168.1.1",
              "logins" => match_array([ "user1", "user2" ])
            ),
            a_hash_including(
              "ip" => "10.0.0.1",
              "logins" => match_array([ "user1", "user3" ])
            )
          )
        end
    end
end
