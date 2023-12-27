json.array! @orders.each do |order|
    json.code order.code
    json.street order.address.street
    json.status order.get_status
end
