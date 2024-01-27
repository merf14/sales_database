# Скрипт для заполнения базы случайными данными

require 'sequel'
require 'faker'
require_relative 'pg_array'
require_relative 'pg_json'
DB = Sequel.connect(adapter: :postgres, user: 'postgres',
                    password: 'password', host: 'localhost', port: 5432, database: 'sales') #Помейняйте пароль на свой
products = DB.from(:products)
purchases = DB.from(:purchases)
customers = DB.from(:customers)
purchases_products = DB.from(:purchases_products)
deliverymen = DB.from(:deliverymen)
deliveries = DB.from(:deliveries)
count = 10 #Введите необходимое значение числа строк в таблицах

(1..count).each do |i|
  products.insert(product_id: i, name: Faker::Food.vegetables, manufacturer: Faker::Company.name, price: rand(1000..20_000), store_ids: Sequel.pg_array(rand(1..100).times.map do Random.rand(1..1000) end))
end

(1..count).each do |i|
  customers.insert(customer_id: i, gender: %w[M F].sample, address: Sequel.pg_jsonb_wrap(Faker::Address.city),
                   reg_date: Faker::Date.between(from: '2023-09-01', to: '2023-12-31'))
end

(1..count).each do |i|
  purchases.insert(purchase_id: i, customer_id: rand(1..count),
                   purchase_date: Faker::Date.between(from: '2023-09-01', to: '2023-12-31'))
end

(1..count).each do |i|
  purchases_products.insert(id: i, product_id: rand(1..count), purchase_id: rand(1..count))
  deliverymen.insert(deliveryman_id: i, name: Faker::Name.name, phone_number: Faker::PhoneNumber.cell_phone_in_e164)
end

(1..count).each do |i|
  deliveries.insert(delivery_id: i, purchase_id: rand(1..count), deliveryman_id: rand(1..count), delivery_days: rand(3..10))
end
