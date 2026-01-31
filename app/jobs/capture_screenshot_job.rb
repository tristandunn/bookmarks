# frozen_string_literal: true

class CaptureScreenshotJob < ApplicationJob
  queue_as :default

  # Captures a screenshot of the bookmark's URL and attaches it.
  #
  # @param bookmark [Bookmark] The bookmark for which to capture a screenshot.
  def perform(bookmark)
    screenshot_data = ScreenshotCapturer.call(bookmark.url)

    return unless screenshot_data

    bookmark.screenshot.attach(
      io: StringIO.new(screenshot_data),
      filename: "screenshot.png",
      content_type: "image/png"
    )
  end
end
