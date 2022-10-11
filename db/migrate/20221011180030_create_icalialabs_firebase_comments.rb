class CreateIcalialabsFirebaseComments < ActiveRecord::Migration[7.0]
  def change
    create_table :icalialabs_firebase_comments do |t|
      t.references :article, null: false, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
