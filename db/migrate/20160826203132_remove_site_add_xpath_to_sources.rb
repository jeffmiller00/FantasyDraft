class RemoveSiteAddXpathToSources < ActiveRecord::Migration[4.2]
  def change
    remove_column :sources, :site
    add_column :sources, :xpath, :string
  end
end
