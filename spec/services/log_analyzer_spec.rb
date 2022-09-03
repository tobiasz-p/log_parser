# frozen_string_literal: true

require 'spec_helper'
require 'services/log_analyzer'
require 'models/log_entry'

RSpec.describe(LogAnalyzer, type: :service) do
  let(:analytics_service) { described_class.new(analytics_data) }

  let(:entry1) { LogEntry.new(path: '/index/1', ip: '127.0.0.1', line_number: 1) }
  let(:entry2) { LogEntry.new(path: '/index/1', ip: '127.0.0.1', line_number: 2) }
  let(:entry3) { LogEntry.new(path: '/index', ip: '127.0.0.1', line_number: 3) }
  let(:entry4) { LogEntry.new(path: '/index', ip: nil, line_number: 4) }
  let(:entry5) { LogEntry.new(path: nil, ip: '127.0.0.1', line_number: 5) }
  let(:entry6) { LogEntry.new(path: '/index/1', ip: '127.0.0.2', line_number: 6) }
  let(:entry7) { LogEntry.new(path: '/index/1', ip: '127.0.0.3', line_number: 7) }

  let(:analytics_data) do
    [
      entry1,
      entry2,
      entry3,
      entry4,
      entry5,
      entry6,
      entry7
    ]
  end

  describe '#invalid_log_entries' do
    subject(:invalid_log_entries) { analytics_service.invalid_log_entries }

    it { is_expected.to(contain_exactly(entry4, entry5)) }
  end

  describe '#most_page_views' do
    subject(:most_page_views) { analytics_service.most_page_views }

    shared_examples 'sorted response' do
      it { expect(most_page_views.size).to(eq(2)) }
      it { expect(most_page_views[0]).to(include('/index/1', 4)) }
      it { expect(most_page_views[1]).to(include('/index', 1)) }
    end

    it_behaves_like 'sorted response'

    context 'when initial order is different' do
      before { analytics_data.reverse! }

      it_behaves_like 'sorted response'
    end
  end

  describe '#uniq_most_page_views' do
    subject(:most_page_views) { analytics_service.uniq_most_page_views }

    shared_examples 'sorted response' do
      it { expect(most_page_views.size).to(eq(2)) }
      it { expect(most_page_views[0]).to(include('/index/1', 3)) }
      it { expect(most_page_views[1]).to(include('/index', 1)) }
    end

    it_behaves_like 'sorted response'

    context 'when initial order is reversed' do
      before { analytics_data.reverse! }

      it_behaves_like 'sorted response'
    end
  end

  describe '#most_client_views' do
    subject(:most_client_views) { analytics_service.most_client_views }

    shared_examples 'sorted response' do
      it { expect(most_client_views.size).to(eq(3)) }
      it { expect(most_client_views[0]).to(include('127.0.0.1', 3)) }
      it { expect(most_client_views[1]).to(include('127.0.0.2', 1)) }
      it { expect(most_client_views[2]).to(include('127.0.0.3', 1)) }
    end

    it_behaves_like 'sorted response'

    context 'when initial order is reversed' do
      before { analytics_data.reverse! }

      it_behaves_like 'sorted response'
    end
  end
end
