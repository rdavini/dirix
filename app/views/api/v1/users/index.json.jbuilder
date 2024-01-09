json.array! @current_user.organization.drivers.each do |driver|
    json.name driver.user.email
end