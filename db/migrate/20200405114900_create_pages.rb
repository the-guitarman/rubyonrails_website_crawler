class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.text :url
      t.text :crawler_config, array: true

      t.timestamps
    end
  end
end
