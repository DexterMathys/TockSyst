class ItemCompra < ActiveRecord::Base

  belongs_to :compra
  belongs_to :producto

end
