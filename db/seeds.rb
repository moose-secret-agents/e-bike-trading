Fabricator(:user) do
  email { Faker::Internet.free_email }
  password 'password'
  password_confirmation 'password'
end

Fabricator(:bid) do
  val = Faker::Number.between(10, 100)
  max_amount { val }
  amount { val }
end

Fabricator(:auction) do
  brand { Faker::Company.name }
  model { Faker::Commerce.product_name }
  price { Faker::Number.between(100, 2000) }
  power { Faker::Number.between(100, 999) }
  range { Faker::Number.between(100, 999) }
  min_increment  5
  end_time { Faker::Time.forward(14, :all) }
  creator { User.all.sample }

  # Seed up to 3 random bids for this auction with a random User as bidder
  bids(rand: 1) { |attrs, i| Fabricate(:bid, bidder: User.all.sample) }
end

# Seed users
User.destroy_all

Fabricate(:user, email: 'test', password: 'test', password_confirmation: 'test')
5.times do
  Fabricate(:user)
end

#Seed auctions with some random bids
Auction.destroy_all

10.times do
  Fabricate(:auction)
end

