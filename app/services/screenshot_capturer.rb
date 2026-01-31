# frozen_string_literal: true

class ScreenshotCapturer
  BROWSER_OPTIONS = {
    headless: "new",
    timeout: 30,
    window_size: [1280, 800]
  }.freeze

  # Initializes a screenshot capturer.
  #
  # @param [String] url The URL to capture.
  def initialize(url)
    @url = url
  end

  # Capture a screenshot of a URL.
  #
  # @return [String] The binary PNG data of the screenshot.
  # @return [nil] If the screenshot cannot be captured.
  def self.call(url)
    new(url).call
  end

  # Capture a screenshot of the URL.
  #
  # @return [String] The binary PNG data of the screenshot.
  # @return [nil] If the screenshot cannot be captured.
  def call
    browser = Ferrum::Browser.new(BROWSER_OPTIONS)

    browser.goto(url)
    browser.screenshot(format: :png, full: true)
  rescue Ferrum::Error
    nil
  ensure
    browser&.quit
  end

  private

  attr_reader :url
end
