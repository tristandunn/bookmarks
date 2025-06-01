# frozen_string_literal: true

require "rails_helper"

describe "bookmarks/index.html.erb" do
  subject(:html) do
    render template: "bookmarks/index", formats: [:html]

    rendered
  end

  let(:bookmarks) { [create(:bookmark), create(:bookmark, created_at: 3.days.ago)] }

  before do
    assign(:bookmarks, bookmarks)
  end

  it "renders the header" do
    expect(html).to have_css("h1", text: t("title"))
  end

  it "renders a link to create a new bookmark" do
    expect(html).to have_link(t("bookmarks.index.add_bookmark"), href: new_bookmark_path)
  end

  it "renders links to each bookmark" do
    bookmarks.each do |bookmark|
      expect(html).to have_link(bookmark.title, href: bookmark.url)
    end
  end

  it "renders the domain of each bookmark" do
    bookmarks.each do |bookmark|
      expect(html).to have_text(bookmark.domain)
    end
  end

  it "renders when each bookmark was added" do
    bookmarks.each do |bookmark|
      expect(html).to have_text(t("bookmarks.index.link.added_on",
                                  date: bookmark.created_at.to_date.to_fs(:long_ordinal),
                                  time: bookmark.created_at.strftime("%l:%M %p")))
    end
  end
end
