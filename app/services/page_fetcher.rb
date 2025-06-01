# frozen_string_literal: true

class PageFetcher
  REQUEST_OPTIONS = { open_timeout: 1, read_timeout: 1, timeout: 1 }.freeze

  # Initializes a page fetcher.
  #
  # @param [String] url The URL to fetch.
  def initialize(url)
    @url = url
  end

  # Attempt to fetch the page.
  #
  # @return [String] The body of the page at the URL.
  # @return [nil] If the URL is invalid or the request fails.
  def self.call(url)
    new(url).call
  end

  # Attempt to fetch the page.
  #
  # @return [String] The body of the page at the URL.
  # @return [nil] If the URL is invalid or the request fails.
  def call
    response = connection.get(url)

    if response.success?
      response.body
    end
  rescue Faraday::Error
    nil
  end

  private

  attr_reader :url

  # Build a Faraday connection with custom options.
  #
  # @return [Faraday::Connection] The Faraday connection used to make requests.
  def connection
    Faraday.new(request: REQUEST_OPTIONS) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end
end
