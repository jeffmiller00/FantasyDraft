class CreatePlayers < ActiveRecord::Migration[4.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :string
      t.references :position, index: true
      t.string :team

      t.timestamps
    end
  end
end
