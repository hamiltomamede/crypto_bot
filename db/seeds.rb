# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
puts "Limpando banco..."
Bot.delete_all
User.delete_all
Company.delete_all

puts "Criando empresas..."
company1 = Company.create!(name: "HM Tech", email:"company@mail.com")

puts "Criando usuários..."

user1 = User.create!(
  name: 'user test',
  email: 'test@mail.com',
  password: 'P4ssw0rd',
  role: :admin,
  company: company1
)


puts "Seeds criados com sucesso!"

