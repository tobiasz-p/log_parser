# frozen_string_literal: true

#
# Service responsible for parsing log
#
class LogParser
  ACCEPTED_FILE_TYPES = ['.log'].freeze

  attr_reader :log_entries

  #
  # @param [String] path
  #
  def initialize(path)
    @absolute_path = File.absolute_path(path)
  end

  #
  # @return [Array<LogEntry>]
  #
  def call!
    @log_entries = []

    raise Exceptions::FileNotFound unless File.exist?(@absolute_path)
    raise Exceptions::FileTypeError unless ACCEPTED_FILE_TYPES.include?(File.extname(@absolute_path))
    raise Exceptions::EmptyFile if File.zero?(@absolute_path)

    parse_file

    raise Exceptions::EmptyFile if @log_entries.empty?

    @log_entries
  end

  private

  def parse_file
    File.open(@absolute_path) do |file|
      file.each do |line|
        @log_entries << parse_line(line, file.lineno) unless line.strip.empty?
      end
    end
  end

  def parse_line(line, line_number)
    attributes = line.split

    LogEntry.new(
      line_number: line_number,
      path: attributes[0],
      ip: attributes[1]
    )
  end
end
