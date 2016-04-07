class Venta < ActiveRecord::Base

  has_many :item_ventas
  has_many :productos, through: :item_ventas
  belongs_to :cliente

end
