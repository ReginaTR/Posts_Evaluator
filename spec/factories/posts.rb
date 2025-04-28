FactoryBot.define do
    factory :post do
      title { "Post Title" }
      body { "Post Body" }
      ip { "192.168.1.1" }
      association :user
    end
end
