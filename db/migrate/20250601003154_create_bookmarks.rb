# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :bookmarks do |t|
      t.string :title, null: false, limit: 255
      t.string :url,   null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
