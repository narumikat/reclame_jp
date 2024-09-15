class AddLikesToComplaintsAndResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :complaints, :likes_count, :integer, default: 0
    add_column :responses, :likes_count, :integer, default: 0
  end
end
