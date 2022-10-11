class CreateIcalialabsFirebaseArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :icalialabs_firebase_articles do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
