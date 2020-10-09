class CreateJoinTableBookCategory < ActiveRecord::Migration[6.0]
  def change
    create_join_table :books, :categories do |t|
      # t.index [:category_id, :book_id]
      # t.index [:book_id, :category_id]
    end
  end
end
