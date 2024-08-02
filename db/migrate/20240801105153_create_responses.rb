class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :complaint, null: false, foreign_key: true

      t.timestamps
    end
  end
end
