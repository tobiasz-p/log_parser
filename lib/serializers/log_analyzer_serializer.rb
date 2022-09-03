# frozen_string_literal: true

#
# Summary serializer
#
class LogAnalyzerSerializer
  #
  # @param [LogAnalyzer] analyzer <description>
  #
  def initialize(analyzer)
    @analyzer = analyzer
  end

  #
  # @return [Hash] <description>
  #
  def as_json
    {
      most_page_views: @analyzer.most_page_views,
      uniq_most_page_views: @analyzer.uniq_most_page_views,
      most_client_views: @analyzer.most_client_views,
      invalid_log_entries: @analyzer.invalid_log_entries.map { |entry| LogEntrySerializer.new(entry).as_json }
    }
  end
end
