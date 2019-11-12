# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false, default: ''
      t.string :original_title
      t.string :poster_path, null: false, default: ''
      t.integer :popularity, null: false, default: 0
      t.string :release_date
      t.text :overview
      t.string :video_key
      t.integer :run_time

      t.timestamps
    end
  end
end
