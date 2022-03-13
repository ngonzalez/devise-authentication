require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a valid user" do
    user = create(:user)
    expect(user.authentication_token).not_to eq(nil)
  end
end
