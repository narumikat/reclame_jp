class AddAnsweredComplaintsCountToCompanies < ActiveRecord::Migration[7.1]
  def change
    add_column :companies, :answered_complaints_count, :integer, default: 0, null: false
  end
end
