# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:question_type) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:answers) }
    it { is_expected.to belong_to(:lesson) }
  end
end
