require 'rails_helper'
RSpec.describe CreateUserJob, type: :job do
  let(:login) { 'user_login' }

  it 'execute curl with correct login' do
    expected_curl = %Q(curl -s -X POST http://localhost:3000/users -H "Content-Type: application/json" -d '{"login": "#{login}"}')

    expect(subject).to receive(:system).with(expected_curl)
    subject.perform(login)
  end
end
