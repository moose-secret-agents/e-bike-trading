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
  description { Faker::Lorem.paragraphs.join('\n') }
  starting_price { Faker::Number.between(100, 2000) }
  power { Faker::Number.between(100, 999) }
  range { Faker::Number.between(100, 999) }
  min_increment  5
  end_time { Faker::Time.forward(3, :all) }
  creator { User.all.sample }
end

# Seed users
User.destroy_all

Fabricate(:user, email: 'test', password: 'test', password_confirmation: 'test')
Fabricate(:user, email: 'test2', password: 'test', password_confirmation: 'test')
5.times do
  Fabricate(:user)
end

#Seed auctions with some random bids
Auction.destroy_all

10.times do
  Fabricate(:auction)
end

10.times do
  auction = Auction.all.sample
  bidder = (User.all - [auction.creator]).sample
  bidder.place_bid_on(auction, auction.next_amount + Faker::Number.between(0, 50))
end

