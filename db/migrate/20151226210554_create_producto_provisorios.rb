class CreateProductoProvisorios < ActiveRecord::Migration
  def change
    create_table :producto_provisorios do |t|
      t.integer :id_producto
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
