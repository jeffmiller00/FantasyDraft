class AddAbbrevToPosition < ActiveRecord::Migration[4.2]
  def change
    add_column :positions, :abbrev, :string
  end
end
