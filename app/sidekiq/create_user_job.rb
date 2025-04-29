class CreateUserJob
  include Sidekiq::Job

  def perform(login)
    system(%Q(curl -s -X POST http://localhost:3000/users -H "Content-Type: application/json" -d '{"login": "#{login}"}'))
  end
end
