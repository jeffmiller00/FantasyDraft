class AddSiteToSources < ActiveRecord::Migration
  def change
    add_column :sources, :site, :string
  end
end
