class AddAbbrevToPosition < ActiveRecord::Migration
  def change
    add_column :positions, :abbrev, :string
  end
end
