json.array! @current_user.organization.warehouses.each do |warehouse|
    json.id warehouse.id
    json.name warehouse.name
    json.lat warehouse.address.latitude
    json.lng warehouse.address.longitude
end