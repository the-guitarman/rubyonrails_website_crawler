class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.text :url, index: { unique: true }

      t.timestamps
    end
  end
end
