# A contact is created whenever FactoryGirl.create(:contact) is used
# Factory file names are not specific and can be whatever.
FactoryGirl.define do
    factory :contact do
        # a {} block is used because factory girl sees it as a "lazy attribute"
        # TODO: Do more research on what lazy attribute actually entails
        # previous version was "static" type
        firstname { Faker::Name.first_name }
        lastname  { Faker::Name.last_name }
        # sequence automatically increments n as new contacts are made.
        # sequence(:email) { |n| "johndoe#{n}@example.com"}
        email     { Faker::Internet.email }
    end
end

