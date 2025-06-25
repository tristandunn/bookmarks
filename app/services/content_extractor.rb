# frozen_string_literal: true

class ContentExtractor
  include ActionView::Helpers::SanitizeHelper

  REMOVE_TAGS = %w(code iframe img pre script style).join(",").freeze

  # Initializes a content extractor for a bookmark.
  #
  # @param [Bookmark] bookmark The bookmark to extract content from.
  def initialize(bookmark)
    @bookmark = bookmark
  end

  # Attempt to extract content from a bookmark.
  #
  # @return [String] The readable content of the bookmark.
  def self.call(bookmark)
    new(bookmark).call
  end

  # Attempt to extract content from a bookmark.
  #
  # @return [String] The readable content of the bookmark.
  def call
    strip_tags(Readability::Document.new(html).content)
  end

  private

  attr_reader :bookmark

  # Return the cleaned HTML body of the page.
  #
  # @return [String] The cleaned HTML body of the page.
  def html
    document = Nokogiri::HTML(page)
    document.css(REMOVE_TAGS).each(&:remove)
    document.css("body").inner_html
  end

  # Return the body of the page.
  #
  # @return [String] The body of the page.
  def page
    PageFetcher.call(bookmark.url)
  end
end
