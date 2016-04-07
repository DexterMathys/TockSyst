class CreateProveedors < ActiveRecord::Migration
  def change
    create_table :proveedors do |t|
      t.text :nombre
      t.text :direccion
      t.text :telefono
      t.float :deuda
      t.text :estado

      t.timestamps null: false
    end
  end
end
