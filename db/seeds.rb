require 'faker'

puts "Generating unique users..."
logins = 100.times.map { "user_#{SecureRandom.hex(4)}" }
logins.each { |login| CreateUserJob.perform_async(login) }

puts "Generating 50 unique IPs..."
ips = Array.new(50) { Faker::Internet.unique.public_ip_v4_address }

puts "Generating 200.000 posts with Sidekiq..."
200_000.times do |i|
  login = logins.sample
  ip = ips.sample
  CreatePostJob.perform_async(login, ip)
end

puts "Generating ratings to 75% of posts..."
(1..200_000).to_a.sample(150_000).each do |post_id|
  user_login = logins.sample
  rating_value = rand(1..5)
  CreateRatingJob.perform_async(post_id, user_login, rating_value)
end

puts "Seeds scheduled by Sidekiq successfully! "
