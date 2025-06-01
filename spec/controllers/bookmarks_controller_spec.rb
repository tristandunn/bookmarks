# frozen_string_literal: true

require "rails_helper"

describe BookmarksController do
  describe "#index" do
    before do
      create(:bookmark, created_at: 1.day.ago)
      create(:bookmark, created_at: 2.days.ago)

      get :index
    end

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:index) }

    it "assigns the bookmarks, newest to oldes" do
      expect(assigns(:bookmarks)).to eq(Bookmark.order(created_at: :desc))
    end
  end

  describe "#new" do
    before do
      get :new
    end

    it { is_expected.to respond_with(200) }
    it { is_expected.to render_template(:new) }

    it "assigns the bookmarks" do
      expect(assigns(:bookmark)).to be_a_new(Bookmark)
    end
  end

  describe "#create" do
    context "when created successfully" do
      before do
        post :create, params: { bookmark: attributes_for(:bookmark) }
      end

      it { is_expected.to redirect_to(root_url) }

      it "creates a bookmark" do
        expect(assigns(:bookmark)).to be_a(Bookmark).and(be_persisted)
      end
    end

    context "when not created successfully" do
      before do
        post :create, params: { bookmark: { title: "", url: "" } }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to render_template(:new) }

      it "assigns the bookmark" do
        expect(assigns(:bookmark)).to be_a_new(Bookmark)
      end
    end
  end
end
