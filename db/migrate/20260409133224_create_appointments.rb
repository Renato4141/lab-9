class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :vet, null: false, foreign_key: true
      t.datetime :date
      t.string :reason
      t.integer :status

      t.timestamps
    end
  end
end
