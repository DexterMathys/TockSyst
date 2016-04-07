class Compra < ActiveRecord::Base

  has_many :item_compras
  has_many :productos, through: :item_compras
  belongs_to :proveedor

end
