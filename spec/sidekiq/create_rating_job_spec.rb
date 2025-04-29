require 'rails_helper'
RSpec.describe CreateRatingJob, type: :job do
  let(:post_id) { 42 }
  let(:login) { 'user_123' }
  let(:value) { 5 }

  it 'execute curl with correct data' do
    expected_payload = {
      post_id: post_id,
      login: login,
      value: value
    }.to_json

    expected_curl = %Q(curl -s -X POST http://localhost:3000/ratings -H "Content-Type: application/json" -d '#{expected_payload}')

    expect(subject).to receive(:system).with(expected_curl)
    subject.perform(post_id, login, value)
  end
end
