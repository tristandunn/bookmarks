# frozen_string_literal: true

require "rails_helper"

describe ScreenshotCapturer do
  describe ".call" do
    subject(:screenshot) { described_class.call(url) }

    let(:url)     { "https://example.com" }
    let(:browser) { instance_double(Ferrum::Browser) }

    before do
      allow(Ferrum::Browser).to receive(:new).and_return(browser)
      allow(browser).to receive(:quit)
    end

    context "when the screenshot is captured successfully" do
      let(:screenshot_data) { "PNG data" }

      before do
        allow(browser).to receive(:goto).with(url)
        allow(browser).to receive(:screenshot).with(format: :png, full: true).and_return(screenshot_data)
      end

      it { is_expected.to eq(screenshot_data) }

      it "quits the browser" do
        screenshot

        expect(browser).to have_received(:quit)
      end
    end

    context "when a Ferrum error occurs" do
      before do
        allow(browser).to receive(:goto).with(url).and_raise(Ferrum::Error)
      end

      it { is_expected.to be_nil }

      it "quits the browser" do
        screenshot

        expect(browser).to have_received(:quit)
      end
    end
  end
end
