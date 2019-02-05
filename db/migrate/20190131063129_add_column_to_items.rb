class AddColumnToItems < ActiveRecord::Migration[5.1]
  def change
    add_column   :items, :trade, :integer, null:false, default: 0
  end
end
