class AddPickedtoPlayers < ActiveRecord::Migration
  def change
    add_column :players, :picked, :boolean
  end
end
