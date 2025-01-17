# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Professor, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:courses) }
  end
end
