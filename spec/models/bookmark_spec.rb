# frozen_string_literal: true

require "rails_helper"

describe Bookmark do
  describe "columns" do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false, limit: 255) }
    it { is_expected.to have_db_column(:url).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe "attachments" do
    it { is_expected.to have_one_attached(:screenshot) }
  end

  describe "validations" do
    subject { create(:bookmark) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }

    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url).case_insensitive }
  end

  describe "#domain" do
    subject { bookmark.domain }

    let(:bookmark) { build(:bookmark, url: url) }

    context "with a root URL" do
      let(:url) { "https://example.com/path/to/resource" }

      it { is_expected.to eq("example.com") }
    end

    context "when the URL has a subdomain" do
      let(:url) { "https://subdomain.example.com/path/to/resource" }

      it { is_expected.to eq("subdomain.example.com") }
    end
  end
end
