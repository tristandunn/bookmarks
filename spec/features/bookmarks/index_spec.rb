# frozen_string_literal: true

require "rails_helper"

describe "Listing bookmarks" do
  let!(:bookmarks) { create_list(:bookmark, 2) }

  before do
    visit "/"
  end

  it "renders links to each bookmark" do
    bookmarks.each do |bookmark|
      expect(page).to have_link(bookmark.title, href: bookmark.url)
    end
  end
end
