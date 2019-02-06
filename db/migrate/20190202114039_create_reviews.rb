class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer     :review, null:false
      t.integer     :giver_id, null:false
      t.integer     :taker_id, null:false
      t.timestamps
    end
  end
end
