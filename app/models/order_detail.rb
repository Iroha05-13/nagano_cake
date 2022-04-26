class OrderDetail < ApplicationRecord

    belongs_to :item
    belongs_to :order
    
    enum making_status: { impossble: 0, waiting: 1, making: 2, finished: 3}
    
end
