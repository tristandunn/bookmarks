# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    title { Faker::Book.title }
    url   { Faker::Internet.url }
  end
end
