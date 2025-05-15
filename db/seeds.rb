# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'

# Nettoyage des données existantes
Booking.delete_all
Accomodation.delete_all
User.delete_all
City.delete_all

# Création des villes
cities = 10.times.map do
  City.create!(name: Faker::Address.unique.city)
end

# Création des utilisateurs
users = 20.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    telephone: "0#{rand(1..9)}#{rand(10..99)} #{rand(10..99)} #{rand(10..99)} #{rand(10..99)}"
  )
end

# Création des logements
accomodations = 50.times.map do
  Accomodation.create!(
    city: cities.sample,
    user: users.sample,
    numb_beds: rand(1..6),
    price_night: rand(30..200),
    description: Faker::Lorem.paragraph(sentence_count: 3),
    welcome_word: Faker::Lorem.sentence(word_count: 8),
    wifi: [ true, false ].sample
  )
end

# Création des réservations pour chaque logement
accomodations.each do |accomodation|
  # 5 réservations dans le passé
  past_bookings = []
  5.times do |i|
    # Diviser l'année passée en 5 segments pour éviter les chevauchements
    segment_start = 1.year.ago + (i * 2.months)
    segment_end = segment_start + 2.months - 1.day
    
    start_date = Faker::Date.between(from: segment_start, to: segment_end - 10.days)
    end_date = start_date + rand(2..10).days
    
    past_bookings << Booking.create!(
      accomodation: accomodation,
      user: users.reject { |u| u.id == accomodation.user_id }.sample,
      start_date: start_date,
      end_date: end_date,
      amount_total: accomodation.price_night * (end_date - start_date).to_i
    )
  end
  
  # 5 réservations dans le futur
  future_bookings = []
  5.times do |i|
    # Diviser l'année à venir en 5 segments pour éviter les chevauchements
    segment_start = Date.today + (i * 2.months) + 1.day
    segment_end = segment_start + 2.months - 1.day
    
    start_date = Faker::Date.between(from: segment_start, to: segment_end - 10.days)
    end_date = start_date + rand(2..10).days
    
    future_bookings << Booking.create!(
      accomodation: accomodation,
      user: users.reject { |u| u.id == accomodation.user_id }.sample,
      start_date: start_date,
      end_date: end_date,
      amount_total: accomodation.price_night * (end_date - start_date).to_i
    )
  end
end
