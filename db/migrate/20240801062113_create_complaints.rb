class CreateComplaints < ActiveRecord::Migration[7.1]
  def change
    create_table :complaints do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: true, foreign_key: true
      t.jsonb :company_social_media, default: []
      t.string :new_company_name
      t.string :title
      t.integer :review
      t.text :comment
      t.string :complaint_category, array: true

      t.timestamps
    end
  end
end
