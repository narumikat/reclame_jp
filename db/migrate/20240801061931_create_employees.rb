class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :role
      t.references :user, null: false, foreign_key: true
      t.references :enterprise, null: false, foreign_key: true
      t.string :business_email
      t.string :phone_number

      t.timestamps
    end
  end
end
