class AddSiteToSources < ActiveRecord::Migration[4.2]
  def change
    add_column :sources, :site, :string
  end
end
