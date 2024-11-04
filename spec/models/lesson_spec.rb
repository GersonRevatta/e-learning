# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:questions) }
    it { is_expected.to belong_to(:course) }
  end
end
