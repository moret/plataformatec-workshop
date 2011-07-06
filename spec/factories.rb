Factory.define :post do |p|
  p.title "My frist post"
  p.body "Hello World!"
end

Factory.define :user do |u|
  u.name "John Doe"
  # Using sequence to avoid duplicate emails
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.password "123456"
end
