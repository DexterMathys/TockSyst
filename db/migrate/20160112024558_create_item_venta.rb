class CreateItemVenta < ActiveRecord::Migration
  def change
    create_table :item_venta do |t|

      t.belongs_to :venta, index: true
      t.belongs_to :producto, index: true
      t.integer :cantidad
      t.float :precio_unitario

      t.timestamps null: false
    end
  end
end
