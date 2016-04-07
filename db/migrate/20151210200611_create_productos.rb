class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.text :nombre
      t.text :descripcion
      t.integer :cantidad
      t.float :precioCompra
      t.float :precioVenta
      t.text :estado

      t.timestamps null: false
    end
  end
end
