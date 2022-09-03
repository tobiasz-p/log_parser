# frozen_string_literal: true

require_relative 'models/log_entry'
require_relative 'serializers/log_analyzer_serializer'
require_relative 'serializers/log_entry_serializer'
require_relative 'services/log_analyzer'
require_relative 'services/log_parser'
require_relative 'exceptions/file_type_error'
require_relative 'exceptions/file_not_found'
require_relative 'exceptions/empty_file'

log_entries = LogParser.new(ARGV[0]).call!

log_analyzer = LogAnalyzer.new(log_entries)

serializer = LogAnalyzerSerializer.new(log_analyzer)

pp serializer.as_json
