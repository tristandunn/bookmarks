# frozen_string_literal: true

require "rails_helper"

describe BookmarkSummarizer do
  describe ".call" do
    subject { described_class.call(bookmark) }

    let(:bookmark) { create(:bookmark) }
    let(:chat)     { instance_double(RubyLLM::Chat) }
    let(:content)  { "HTML body.\nMore." }
    let(:prompt)   { format(described_class::SUMMARY_PROMPT, content) }
    let(:summary)  { "This is a summary of the HTML body." }

    before do
      message = instance_double(RubyLLM::Message, content: summary)

      allow(ContentExtractor).to receive(:call).with(bookmark).and_return(content)
      allow(RubyLLM).to receive(:chat).and_return(chat)
      allow(chat).to receive(:ask).with(prompt).and_return(message)
    end

    context "when successful" do
      it { is_expected.to eq(summary) }
    end

    context "with an error" do
      before do
        allow(chat).to receive(:ask).with(prompt).and_raise(StandardError)
      end

      it { is_expected.to be_nil }
    end
  end
end
