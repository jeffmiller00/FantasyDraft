class CreateSources < ActiveRecord::Migration[4.2]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :url
      t.decimal :weight

      t.timestamps
    end
  end
end
