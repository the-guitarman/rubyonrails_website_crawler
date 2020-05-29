class CreateUrlPatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :url_patterns do |t|
      t.text :url, index: { unique: true }
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
