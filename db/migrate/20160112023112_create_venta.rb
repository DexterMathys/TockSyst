class CreateVenta < ActiveRecord::Migration
  def change
    create_table :venta do |t|

      t.date :fecha
      t.references :cliente
      t.float :total

      t.timestamps null: false
    end
  end
end
