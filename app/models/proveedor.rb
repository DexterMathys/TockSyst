class Proveedor < ActiveRecord::Base

  has_many :compras

  validates_presence_of :nombre
  validates_presence_of :deuda

  validates_numericality_of :deuda

  validates_uniqueness_of :nombre

end
