class CreateComplaints < ActiveRecord::Migration[7.1]
  def change
    create_table :complaints do |t|
      t.references :user, null: false, foreign_key: true
      t.references :enterprise, null: false, foreign_key: true
      t.jsonb :company_social_media, default: []
      t.text :review
      t.text :comment

      t.timestamps
    end
  end
end
