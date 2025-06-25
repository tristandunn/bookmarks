# frozen_string_literal: true

require "rails_helper"

describe ContentExtractor do
  describe ".call" do
    subject(:extractor) { described_class.call(bookmark) }

    let(:bookmark)         { create(:bookmark, url: "https://example.com") }
    let(:clean_html)       { "<p>HTML body.</p>\n<p>More.</p>" }
    let(:raw_html)         { "<body>#{clean_html}<code>alert(1);</code></body>" }
    let(:readable_content) { "HTML body.\nMore." }

    before do
      allow(PageFetcher).to receive(:call).with(bookmark.url).and_return(raw_html)
      allow(Readability::Document).to receive(:new)
        .with(clean_html)
        .and_return(instance_double(Readability::Document, content: clean_html))
    end

    it { is_expected.to eq(readable_content) }
  end
end
