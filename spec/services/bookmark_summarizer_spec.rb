# frozen_string_literal: true

require "rails_helper"

describe BookmarkSummarizer do
  describe ".call" do
    subject { described_class.call(bookmark) }

    let(:bookmark)   { create(:bookmark) }
    let(:chat)       { instance_double(RubyLLM::Chat) }
    let(:clean_html) { "<p>HTML body.</p>\n<p>More.</p>" }
    let(:prompt)     { format(described_class::SUMMARY_PROMPT, "HTML body.\nMore.") }
    let(:summary)    { "This is a summary of the HTML body." }

    before do
      message = instance_double(RubyLLM::Message, content: summary)

      allow(PageFetcher).to receive(:call).with(bookmark.url)
                                          .and_return("#{clean_html}<code>alert(1);</code>")
      allow(Readability::Document).to receive(:new)
        .with(clean_html)
        .and_return(instance_double(Readability::Document, content: clean_html))

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
