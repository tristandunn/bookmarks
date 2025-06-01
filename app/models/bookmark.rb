# frozen_string_literal: true

class Bookmark < ApplicationRecord
  MAXIMUM_TITLE_LENGTH = 255

  validates :title, presence: true, length: { maximum: MAXIMUM_TITLE_LENGTH }
  validates :url,   presence: true, uniqueness: { case_sensitive: false }

  # Returns the domain of the bookmark's URL.
  #
  # @return [String] The domain of the bookmark's URL.
  def domain
    @domain ||= URI.parse(url).host
  end
end
