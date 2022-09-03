# frozen_string_literal: true

require 'services/log_parser'
require 'models/log_entry'

RSpec.describe LogParser do
  let(:file_path) { 'spec/files/webserver.log' }

  describe '#call' do
    subject(:call) { described_class.new(file_path).call! }

    it { is_expected.to be_instance_of(Array) }
    it { is_expected.to include(a_kind_of(LogEntry)) }

    it { expect(call.size).to eq 4 }
    it { expect { call }.not_to raise_error }

    context 'when file is empty' do
      let(:file_path) { 'spec/files/empty_file.log' }

      it { expect { call }.to raise_error(Exceptions::EmptyFile) }
    end

    context 'when file does not exists' do
      let(:file_path) { 'spec/files/missing_file.log' }

      it { expect { call }.to raise_error(Exceptions::FileNotFound) }
    end

    context 'when file type is different than allowed' do
      let(:file_path) { 'spec/files/addresses.csv' }

      it { expect { call }.to raise_error(Exceptions::FileTypeError) }
    end

    context 'when file contains only empty lines' do
      let(:file_path) { 'spec/files/null_entries.log' }

      it { expect { call }.to raise_error(Exceptions::EmptyFile) }
    end
  end
end
