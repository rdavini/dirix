json.array! @orders.each do |order|
    json.code order.code
    json.street order.address.address_short
    json.status order.get_status
    json.id 2
    json.lat order.address.lat
    json.lng order.address.lng
    json.email "teste@gmail.com"
    json.dist order.distance_from_src
end
