require 'rails_helper'

describe Finders::UserFinderService do
  describe ".search" do
    let!(:user) { create(:user, email: 'juan@gmail.com') }
    let(:params) {{ query:'juan@gmail.com' }}
    let(:params2) {{ query:'juan2@gmail.com' }}
    it "returns results with matching query" do
      results = Finders::UserFinderService.new(params).search
      expect(results).to include(user)
    end
    it "doesnt return results without matching query" do
      results = Finders::UserFinderService.new(params2).search
      expect(results).not_to include(user)
    end
  end
end