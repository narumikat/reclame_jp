class CreateJoinTableCompaniesUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :companies, :users do |t|
      t.index :company_id
      t.index :user_id
      t.string :role
    end
  end
end
