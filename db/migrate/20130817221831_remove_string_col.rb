class RemoveStringCol < ActiveRecord::Migration[4.2]
  def change
    remove_column :players, :string
  end
end
