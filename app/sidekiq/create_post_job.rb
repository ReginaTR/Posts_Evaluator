class CreatePostJob
  include Sidekiq::Job

  def perform(login, ip)
    post_data = {
      login: login,
      post: {
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        ip: ip
      }
    }

    system(%Q(curl -s -X POST http://localhost:3000/posts -H "Content-Type: application/json" -d '#{post_data.to_json}'))
  end
end
