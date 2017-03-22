FactoryGirl.define do

  factory :city_fixed, class: 'City' do
    name 'test'
  end

  factory :city, :parent => :city_fixed do
  end

  factory :city_sequence, class: 'City' do
    sequence(:name) { |n| "test#{n}" }
  end

  factory :city_names, class: 'City' do
    sequence(:name) { |n| ["larry", "moe", "curly"][n%3] }
  end

  factory :city_transient, class: 'City' do
    transient do
      large true
    end

    after(:build) do |object, props|
      object.name = props.large ? "Large City" : "Small City"
    end
  end

  # For an immutable object
  factory :city_ctor, class: 'City' do
    transient do
      hash {}
    end
    initialize_with { City.new(hash) }
  end
end
