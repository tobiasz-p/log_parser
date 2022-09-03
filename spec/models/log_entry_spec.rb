# frozen_string_literal: true

require 'models/log_entry'

RSpec.describe LogEntry, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:line_number) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:ip) }
  end
end
