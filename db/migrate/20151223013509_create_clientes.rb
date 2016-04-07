class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.text :nombre
      t.text :direccion
      t.text :telefono
      t.float :deuda
      t.text :estado

      t.timestamps null: false
    end
  end
end
