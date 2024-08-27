class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :company_register_number
      t.string :company_address
      t.string :company_city
      t.string :company_prefecture
      t.string :company_zip_code
      t.string :company_country
      t.string :company_phone_number
      t.string :company_website
      t.jsonb :company_social_media, default: []
      t.text :company_description
      t.string :company_category
      t.string :company_contact_name
      t.string :company_contact_email
      t.string :company_banner_url
      t.string :company_logo_url

      t.timestamps
    end
  end
end
