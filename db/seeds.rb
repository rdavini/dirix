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

address = Address.find_or_create_by({
  street: "rua barao do campo mistico",
  number: 80,
  block: "santa angela",
  city: "poços de caldas",
  state: "MG",
  zip: 37701039
})

address2 = Address.find_or_create_by({
  street: "R. Assis Figueiredo",
  number: 1748,
  block: "Centro",
  city: "poços de caldas",
  state: "MG",
  zip: 37701704
})

Order.create({
    code: "1",
    organization: org.organization,
    address: address
})

Order.create({
    code: "2",
    organization: org.organization,
    address: address2
})