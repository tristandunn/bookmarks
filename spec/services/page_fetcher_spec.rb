# frozen_string_literal: true

require "rails_helper"

describe PageFetcher do
  describe ".call" do
    subject { described_class.call(url) }

    let(:url) { "https://example.com" }

    context "with a valid URL" do
      before do
        stub_request(:get, url).to_return(body: "HTML body.")
      end

      it { is_expected.to eq("HTML body.") }
    end

    context "with an unsuccessful response" do
      before do
        stub_request(:get, url).to_return(status: 404)
      end

      it { is_expected.to be_nil }
    end

    context "with a request or response error" do
      before do
        stub_request(:get, url).to_raise(Faraday::Error)
      end

      it { is_expected.to be_nil }
    end
  end
end
