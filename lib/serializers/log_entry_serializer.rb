# frozen_string_literal: true

#
# The +LogEntry+ Serializer
#
class LogEntrySerializer < SimpleDelegator
  #
  # @return [Hash]
  #
  def as_json
    {
      path: path,
      line_number: line_number,
      ip: ip
    }
  end
end
