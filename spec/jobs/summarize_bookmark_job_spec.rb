# frozen_string_literal: true

require "rails_helper"

describe SummarizeBookmarkJob do
  describe "queue" do
    it "is in the default queue" do
      expect(described_class.queue_name).to eq("default")
    end
  end

  describe "#perform" do
    subject(:perform) { described_class.perform_now(bookmark) }

    before do
      allow(BookmarkSummarizer).to receive(:call).with(bookmark).and_return(summary)
    end

    context "when the bookmark is summarized" do
      let(:bookmark) { create(:bookmark) }
      let(:summary)  { Faker::Lorem.sentence }

      it "updates the bookmark with the summary" do
        perform

        expect(bookmark.reload.summary).to eq(summary)
      end
    end

    context "when the bookmark fails to be summarized" do
      let(:bookmark) { create(:bookmark, summary: "Existing summary.") }
      let(:summary)  { nil }

      it "clears the bookmark summary" do
        perform

        expect(bookmark.reload.summary).to eq(summary)
      end
    end
  end
end
