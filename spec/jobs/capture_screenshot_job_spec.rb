# frozen_string_literal: true

require "rails_helper"

describe CaptureScreenshotJob do
  describe "queue" do
    it "is in the default queue" do
      expect(described_class.queue_name).to eq("default")
    end
  end

  describe "#perform" do
    subject(:perform) { described_class.perform_now(bookmark) }

    let(:bookmark) { create(:bookmark) }

    before do
      allow(ScreenshotCapturer).to receive(:call).with(bookmark.url).and_return(screenshot_data)
    end

    context "when the screenshot is captured successfully" do
      let(:screenshot_data) { "PNG data" }

      it "attaches the screenshot to the bookmark" do
        perform

        expect(bookmark.reload.screenshot).to be_attached
      end
    end

    context "when the screenshot capture fails" do
      let(:screenshot_data) { nil }

      it "does not attach a screenshot" do
        perform

        expect(bookmark.reload.screenshot).not_to be_attached
      end
    end
  end
end
