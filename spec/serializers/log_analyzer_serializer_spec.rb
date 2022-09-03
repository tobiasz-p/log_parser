# frozen_string_literal: true

require 'spec_helper'
require 'serializers/log_analyzer_serializer'
require 'serializers/log_entry_serializer'
require 'services/log_analyzer'
require 'services/log_parser'
require 'models/log_entry'

RSpec.describe(LogAnalyzerSerializer, type: :presenter) do
  let(:log_analyzer_serializer) { described_class.new(log_analyzer) }
  let(:log_analyzer) { LogAnalyzer.new(log_entries) }
  let(:log_entries) { LogParser.new(file_path).call! }
  let(:file_path) { 'spec/files/webserver.log' }

  describe '#as_json' do
    subject(:as_json) { log_analyzer_serializer.as_json }

    it { expect(as_json[:most_page_views].size).to(eq(3)) }
  end
end
