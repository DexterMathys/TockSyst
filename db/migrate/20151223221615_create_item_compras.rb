class CreateItemCompras < ActiveRecord::Migration
  def change
    create_table :item_compras do |t|

      t.belongs_to :compra, index: true
      t.belongs_to :producto, index: true
      t.integer :cantidad
      t.float :precio_unitario

      t.timestamps null: false
    end
  end
end
