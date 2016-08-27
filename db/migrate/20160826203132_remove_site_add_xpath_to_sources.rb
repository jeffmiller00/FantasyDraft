class RemoveSiteAddXpathToSources < ActiveRecord::Migration
  def change
    remove_column :sources, :site
    add_column :sources, :xpath, :string
  end
end
