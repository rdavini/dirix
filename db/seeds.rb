# Create an organization
org = User.create({
  email: 'organization@gmail.com',
  password: 'estrelas',
  phone: '3712-2121',
  role: User.roles["organization"]
})

# # Create a driver associated with the organization
driver = User.create({
  email: 'driver@gmail.com',
  password: 'estrelas',
  phone: '3712-2121',
  role: User.roles["driver"]
})
