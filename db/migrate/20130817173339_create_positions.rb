class CreatePositions < ActiveRecord::Migration[4.2]
  def change
    create_table :positions do |t|
      t.string :name

      t.timestamps
    end
  end
end
