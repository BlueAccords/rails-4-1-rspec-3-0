# A contact is created whenever FactoryGirl.create(:contact) is used
# Factory file names are not specific and can be whatever.
FactoryGirl.define do
    factory :contact do
        firstname "John"
        lastname "Doe"
        # sequence automatically increments n as new contacts are made.
        sequence(:email) { |n| "johndoe#{n}@example.com"}
    end
end

