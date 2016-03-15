# A contact is created whenever FactoryGirl.create(:contact) is used
# Factory file names are not specific and can be whatever.
FactoryGirl.define do
    factory :contact do
        # a {} block is used because factory girl sees it as a "lazy attribute"
        # TODO: Do more research on what lazy attribute actually entails
        # previous version was "static" type
        firstname { FFaker::Name.first_name }
        lastname  { FFaker::Name.last_name }
        # sequence automatically increments n as new contacts are made.
        # sequence(:email) { |n| "johndoe#{n}@example.com"}
        email     { FFaker::Internet.email }

        # callback function
        # gets the newly built contact as contact
        # and iterates over an array of factory made phones
        # and adds each one to the phones field for the contact
        # after using factoryGirl to build the phones
        after(:build) do |contact|
            [:home_phone, :work_phone, :mobile_phone].each do |phone|
                contact.phones << FactoryGirl.build(:phone,
                    phone_type: phone, contact: contact)
            end
        end
    end
end

