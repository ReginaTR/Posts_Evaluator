require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'validations' do
    subject { Rating.new(post: Post.new(user: User.new(login: 'user_login'), title: 'Title', body: 'Body', ip: '127.0.0.1'), user: User.new(login: 'user_login_2'), value: 3) }

    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:value) }
    it { should validate_inclusion_of(:value).in_range(1..5) }

    it 'validates uniqueness of user scoped to post' do
      user = User.create!(login: 'user_test')
      post = Post.create!(title: 'Post title', body: 'Post body', ip: '127.0.0.1', user: user)

      Rating.create!(post: post, user: user, value: 4)

      duplicate_rating = Rating.new(post: post, user: user, value: 5)
      expect(duplicate_rating.valid?).to be_falsey
      expect(duplicate_rating.errors[:user_id]).to include('has already rated this post')
    end
  end
end
