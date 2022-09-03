# frozen_string_literal: true

require 'active_model'

class LogEntry
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :line_number, :path, :ip

  validates :line_number, presence: true
  validates :path, presence: true
  validates :ip, presence: true
end
