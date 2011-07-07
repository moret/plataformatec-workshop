Factory.define :post do |p|
  p.title "My frist post"
  p.body "Hello World!"
  p.association :user
end

Factory.define :user do |u|
  u.name "John Doe"
  # Using sequence to avoid duplicate emails
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.password "123456"
end

Factory.define :attachment do |a|
  a.name "Rails Logo"
  a.attachment File.open("spec/fixtures/rails.png")
end

Factory.define :comment do |c|
  c.body "Post rulez!"
  c.association :post
end
