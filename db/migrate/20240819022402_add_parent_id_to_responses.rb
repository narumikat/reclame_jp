class AddParentIdToResponses < ActiveRecord::Migration[7.1]
  def change
    add_reference :responses, :parent, foreign_key: { to_table: :responses }
  end
end
