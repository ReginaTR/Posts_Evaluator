require 'rails_helper'
RSpec.describe CreatePostJob, type: :job do
  let(:login) { 'user_login' }
  let(:ip)    { '192.168.0.100' }

  it 'execute curl with correct data to create post' do
    fake_title = 'Fake title'
    fake_body  = 'Fake body'

    allow(Faker::Lorem).to receive(:sentence).and_return(fake_title)
    allow(Faker::Lorem).to receive(:paragraph).and_return(fake_body)

    expected_post_data = {
      login: login,
      post: {
        title: fake_title,
        body: fake_body,
        ip: ip
      }
    }

    expected_curl_command = %Q(curl -s -X POST http://localhost:3000/posts -H "Content-Type: application/json" -d '#{expected_post_data.to_json}')

    expect(subject).to receive(:system).with(expected_curl_command)
    subject.perform(login, ip)
  end
end
