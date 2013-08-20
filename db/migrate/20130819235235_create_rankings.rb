class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :source, index: true
      t.references :player, index: true
      t.integer :overall_rank
      t.integer :pos_rank

      t.timestamps
    end
  end
end
