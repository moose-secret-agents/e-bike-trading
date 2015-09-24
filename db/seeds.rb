Fabricator(:auction) do
  brand { Faker::Company.name }
  model { Faker::Commerce.product_name }
  price { Faker::Commerce.price }
  power { Faker::Number.between(100, 999) }
  range { Faker::Number.between(100, 999) }
  end_time { Faker::Time.forward(14, :all) }
end

10.times do
  Fabricate(:auction)
end

