# frozen_string_literal: true

class ChengeUniqueIndexToLike < ActiveRecord::Migration[5.2]
  def change
    add_index :likes, %i[user_id post_id], unique: true
  end
end
