FactoryGirl.define do
  factory :budgie do
    id 1
    name FFaker::Lorem.word

    trait :male do
      gender true
    end

    trait :female do
      gender false
    end

    color_id 1
    age 15
    tribal false
    father_id 2
    mother_id 3
  end

  factory :budgie_male, traits: :male
  factory :budgie_female, traits: :female
end
