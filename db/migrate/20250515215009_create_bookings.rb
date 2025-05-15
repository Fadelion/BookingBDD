class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :amount_total, precision: 10, scale: 2, null: false
      t.references :accomodation, null: false, foreign_key: { on_delete: :restrict }
      t.references :user, null: false, foreign_key: { on_delete: :restrict }

      t.timestamps
    end

    # Ajout d'un index
    add_index :bookings, [:accomodation_id, :start_date, :end_date]
  end
end
