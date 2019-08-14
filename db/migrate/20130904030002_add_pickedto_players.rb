class AddPickedtoPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :picked, :boolean
  end
end
