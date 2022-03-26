require 'rails_helper'

RSpec.describe Adventurer, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :level}
    it {should validate_presence_of :party_id}
  end
end
