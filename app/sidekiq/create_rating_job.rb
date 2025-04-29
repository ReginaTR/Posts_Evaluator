class CreateRatingJob
  include Sidekiq::Job

  def perform(post_id, user_login, value)
    rating_data = {
      post_id: post_id,
      login: user_login,
      value: value
    }

    system(%Q(curl -s -X POST http://localhost:3000/ratings -H "Content-Type: application/json" -d '#{rating_data.to_json}'))
  end
end
