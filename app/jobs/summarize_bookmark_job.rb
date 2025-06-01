# frozen_string_literal: true

class SummarizeBookmarkJob < ApplicationJob
  queue_as :default

  # Attempts to summarize the content of a given bookmark.
  #
  # @param bookmark [Bookmark] The bookmark for which to fetch and summarize content.
  def perform(bookmark)
    summary = BookmarkSummarizer.call(bookmark)

    bookmark.update!(summary: summary)
  end
end
