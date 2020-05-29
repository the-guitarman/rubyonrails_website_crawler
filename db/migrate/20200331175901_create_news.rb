class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title, index: { unique: true }
      t.text :url
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
  end
end
