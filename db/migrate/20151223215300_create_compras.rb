class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|

      t.date :fecha
      t.references :proveedor
      t.float :total

      t.timestamps null: false
    end
  end
end
