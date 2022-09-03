# frozen_string_literal: true

class LogEntry
  include ActiveModel::Model

  attr_accessor :line_number, :path, :ip

  validates :line_number, presence: true
  validates :path, presence: true
  validates :ip, presence: true
end
