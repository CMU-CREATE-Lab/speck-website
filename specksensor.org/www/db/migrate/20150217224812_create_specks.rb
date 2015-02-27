class CreateSpecks < ActiveRecord::Migration
  def change
    create_table :specks do |t|
      t.string :serial_number
      t.string :firmware
      t.timestamps
    end
  end
end
