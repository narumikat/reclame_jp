class CreateAds < ActiveRecord::Migration[7.1]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :url
      t.string :ad_type
      t.string :location
      t.integer :views
      t.integer :clicks
      t.boolean :active

      t.timestamps
    end
  end
end
