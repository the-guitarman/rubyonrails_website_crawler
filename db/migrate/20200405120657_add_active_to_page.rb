class AddActiveToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :active, :boolean, default: true
  end
end
