# frozen_string_literal: true

class BookmarkSummarizer
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

  # Return the readable content of the bookmark.
  #
  # @return [String] The readable content of the bookmark.
  def readable_content
    ContentExtractor.call(bookmark)
  end
end
