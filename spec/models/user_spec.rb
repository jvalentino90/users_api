require "rails_helper"

describe User do
  describe 'Factories' do
    context 'user' do
      it { expect(build(:user)).to be_valid }
    end
  end

  it "saves a valid User" do
    user = build(:user)
    user.save
    expect(user).to be_valid
  end

  it "doesnt save a user" do
    user = build(:user, email: nil)
    user.save
    expect(user).not_to be_valid
  end

end