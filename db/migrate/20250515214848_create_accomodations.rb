class CreateAccomodations < ActiveRecord::Migration[8.0]
  def change
    create_table :accomodations do |t|
      t.integer :numb_beds
      t.decimal :price_night
      t.text :description
      t.boolean :wifi
      t.text :welcome_word
      t.references :city, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
