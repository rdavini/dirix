json.id @current_user.id
json.email @current_user.email
json.photo @current_user.photo
json.phone @current_user.phone
json.role @current_user.role
if @current_user.role == "driver"
    json.driver @current_user.driver
    json.working_info @current_user.driver.working_days.find_by(date: Date.today) 
end