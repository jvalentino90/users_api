FactoryBot.define do
  factory :user, class: User do
    full_name FFaker::Name.name
    phone_number FFaker::PhoneNumber.short_phone_number
    key "12345678"
    email FFaker::Internet.email
    metadata FFaker::Lorem.sentence
    password FFaker::Lorem.word
  end
 end