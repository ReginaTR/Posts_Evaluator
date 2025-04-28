class AddUniqueIndexToRatings < ActiveRecord::Migration[8.0]
  def change
    add_index :ratings, [ :post_id, :user_id ], unique: true
  end
end
