class CreateWebsiteAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :website_admins do |t|
      t.references :person, foreign_key: true
      t.integer :adminrights

      t.timestamps
    end
  end
end
