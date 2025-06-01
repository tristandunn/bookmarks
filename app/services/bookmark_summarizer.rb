# frozen_string_literal: true

class BookmarkSummarizer
  include ActionView::Helpers::SanitizeHelper

  REMOVE_TAGS    = %w(code iframe img pre script style).join(",").freeze
  SUMMARY_PROMPT = <<~PROMPT
    Summarize this text in 255 characters or fewer. Output only the summary.

    Text:
    %s
  PROMPT

  # Initializes a bookmark summarizer.
  #
  # @param [String] bookmark The bookmark to summarize.
  def initialize(bookmark)
    @bookmark = bookmark
  end

  # Attempt to summarize a bookmark.
  #
  # @return [String] The summary of the bookmark.
  # @return [nil] If the bookmark summary could not be generated.
  def self.call(bookmark)
    new(bookmark).call
  end

  # Attempt to summarize the bookmark.
  #
  # @return [String] The summary of the bookmark.
  # @return [nil] If the bookmark summary could not be generated.
  def call
    RubyLLM.chat
           .ask(format(SUMMARY_PROMPT, readable_content))
           .content.presence
  rescue StandardError
    nil
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

  # Return the readable content of the page with tags stripped.
  #
  # @return [String] The readable content of the page.
  def readable_content
    strip_tags(Readability::Document.new(html).content)
  end
end
