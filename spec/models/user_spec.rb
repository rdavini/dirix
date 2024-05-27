require 'rails_helper'

RSpec.describe User, type: :model do
    it 'returns a full user' do
        user = create(:user, name: "abc")

        expect user.name = "abc"
    end
end
