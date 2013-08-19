class RemoveStringCol < ActiveRecord::Migration
  def change
    remove_column :players, :string
  end
end
