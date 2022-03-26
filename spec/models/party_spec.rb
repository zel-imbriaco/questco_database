require 'rails_helper'

RSpec.describe 'Party', type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :rank}
    it {should validate_presence_of :active}
  end
end