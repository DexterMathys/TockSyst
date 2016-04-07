class Producto < ActiveRecord::Base

  validates_presence_of :nombre
  validates_presence_of :cantidad
  validates_presence_of :precioCompra
  validates_presence_of :precioVenta

  validates_numericality_of :cantidad
  validates_numericality_of :precioCompra
  validates_numericality_of :precioVenta

  validates_uniqueness_of :nombre

  has_many :item_compras
  has_many :compras, through: :item_compras

  has_many :item_ventas
  has_many :ventas, through: :item_ventas

end
