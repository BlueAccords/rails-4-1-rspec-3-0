FactoryGirl.define do
    factory :phone do
        # call to association creates a new contact for the phone to belong to
        # if one was not created specifically for it upon creation
        association :contact
        phone { Faker::PhoneNumber.phone_number }
        phone_type 'home'

        factory :home_phone do
            phone_type 'home'
        end

        factory :work_phone do
            phone_type 'work'
        end

        factory :mobile_phone do
            phone_type 'mobile'
        end
    end
end
