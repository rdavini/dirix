# Create an organization
org = User.create({
  email: 'organization@gmail.com',
  password: 'estrelas',
  phone: '3712-2121',
  role: User.roles["organization"]
})

warehouse = Warehouse.create( name: 'deposito padrao',
                address: Address.find_or_create_by({
                  street: "R. Italo Zingoni",
                  number: 89,
                  block: "Centro",
                  city: "poços de caldas",
                  state: "MG",
                  zip: 37701287,
                  latitude: -21.804455,
                  longitude: -46.573587
                }),
                organization: org.organization)


# Create a driver associated with the organization
driver = User.create({
  email: 'driver@gmail.com',
  password: 'estrelas',
  phone: '3712-2121',
  role: User.roles["driver"],
  organization_id: org.id
})

address = Address.find_or_create_by({
      street: "R. barao do campo mistico",
      number: 655,
      block: "Centro",
      city: "poços de caldas",
      state: "MG",
      zip: 37701039,
      latitude: -21.7941761,
      longitude: -46.5699732
    })

Order.create({
    code: "1",
    address: address,
    distance_from_src: Google::DistanceAPI.get_distance_matrix(warehouse.address.address, address.address),
    organization: org.organization
})

address2 = Address.find_or_create_by({
  street: "R. Assis Figueiredo",
  number: 1748,
  block: "Centro",
  city: "poços de caldas",
  state: "MG",
  zip: 37701704,
  latitude: -21.7939721,
  longitude: -46.5674133
})

Order.create({
    code: "2",
    address: address2,
    distance_from_src: Google::DistanceAPI.get_distance_matrix(warehouse.address.address, address2.address),
    organization: org.organization
})