json.array! @orders.each do |order|
    json.code order.code
    json.street order.address.street
    json.status order.get_status
    json.id 2
    json.lat order.address.latitude
    json.lng order.address.longitude
    json.email "teste@gmail.com"
    json.dist "2"
end
