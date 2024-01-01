json.array! @current_user.organization.employees.each do |driver|
    json.name driver.user.email
end