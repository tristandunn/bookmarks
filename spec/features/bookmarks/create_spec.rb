# frozen_string_literal: true

require "rails_helper"

describe "Listing bookmarks" do
  let(:attributes) { attributes_for(:bookmark) }

  before do
    visit "/"
    click_link t("bookmarks.index.add_bookmark")
  end

  it "creates a new bookmark" do
    fill_in t("activerecord.attributes.bookmark.title"), with: attributes[:title]
    fill_in t("activerecord.attributes.bookmark.url"),   with: attributes[:url]
    click_button t("bookmarks.new.submit")

    expect(page).to have_link(attributes[:title], href: attributes[:url])
  end
end
