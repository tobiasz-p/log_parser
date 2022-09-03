# frozen_string_literal: true

#
# Service responsible for filtering responses
#
#
class LogAnalyzer
  attr_reader :log_entries

  #
  # @param [Array<LogEntry>] log_entries
  #
  def initialize(log_entries)
    @log_entries = log_entries
  end

  #
  # @return [Array<LogEntry>]
  #
  def invalid_log_entries
    @invalid_log_entries ||= @log_entries.select(&:invalid?)
  end

  #
  # @return [Array<Array[String, Integer]>]
  #
  def most_page_views
    @most_page_views ||= group_by(valid_entries, &:path)
  end

  #
  # @return [Array<Array[Array<String>, Integer]>]
  #
  def uniq_most_page_views
    @uniq_most_page_views ||= group_by(uniq_valid_entries, &:path)
  end

  #
  # @return [Array<Array[String, Integer]>]
  #
  def most_client_views
    @most_client_views ||= group_by(valid_entries, &:ip)
  end

  private

  def group_by(entries, &block)
    entries.group_by(&block)
           .map { |k, v| [k, v.size] }
           .sort { |a, b| [b[1], a[0]] <=> [a[1], b[0]] }
  end

  def valid_entries
    @valid_entries ||= @log_entries - invalid_log_entries
  end

  def uniq_valid_entries
    @uniq_valid_entries ||= valid_entries.uniq { |entry| [entry.path, entry.ip] }
  end
end
