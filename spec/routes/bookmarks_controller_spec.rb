# frozen_string_literal: true

require "rails_helper"

describe BookmarksController, type: :routing do
  it { is_expected.to route(:get, "/").to(action: :index) }
  it { is_expected.to route(:get, "/bookmarks/new").to(action: :new) }
  it { is_expected.to route(:post, "/bookmarks").to(action: :create) }
end
