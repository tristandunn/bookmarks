# frozen_string_literal: true

require "rails_helper"

describe "bookmarks/new.html.erb" do
  subject(:html) do
    render template: "bookmarks/new"

    rendered
  end

  let(:bookmark) { Bookmark.new }

  before do
    assign :bookmark, bookmark
  end

  it "renders a form to create an bookmark" do
    expect(html).to have_css(
      %(form.highlight-errors[action="#{bookmarks_path}"][method="post"])
    )
  end

  it "renders a title field" do
    expect(html).to have_css(%(input#bookmark_title[autofocus][required]))
  end

  it "renders a URL field" do
    expect(html).to have_css(%(input#bookmark_url[required]))
  end

  it "renders a submit button" do
    expect(html).to have_button(t("bookmarks.new.submit"))
  end

  context "when errors are present" do
    before do
      bookmark.errors.add(:title, :invalid)
      bookmark.errors.add(:url, :invalid)
    end

    it "wraps title field in error container" do
      expect(html).to have_css(".field_with_errors #bookmark_title")
    end

    it "displays title error message" do
      expect(html).to have_css("p", text: [
        Bookmark.human_attribute_name(:title).humanize,
        t("errors.messages.invalid")
      ].join(" "))
    end

    it "wraps URL field in error container" do
      expect(html).to have_css(".field_with_errors #bookmark_url")
    end

    it "displays URL error message" do
      expect(html).to have_css("p", text: [
        Bookmark.human_attribute_name(:url).humanize,
        t("errors.messages.invalid")
      ].join(" "))
    end
  end
end
