# frozen_string_literal: true

class BookmarksController < ApplicationController
  # Display all the bookmarks.
  def index
    @bookmarks = Bookmark.order(created_at: :desc)
  end

  # Display the form to create a new bookmark.
  def new
    @bookmark = Bookmark.new
  end

  # Create a new bookmark.
  def create
    @bookmark = Bookmark.new(bookmark_parameters)

    if @bookmark.save
      redirect_to root_url
    else
      render :new
    end
  end

  protected

  # Return the permitted parameters from the required bookmark parameter.
  #
  # @return [ActionController::Parameters]
  def bookmark_parameters
    params.expect(bookmark: %i(title url))
  end
end
