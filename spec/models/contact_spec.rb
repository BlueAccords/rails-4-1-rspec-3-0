require "rails_helper"

# USe FactoryGirl.build to store a test object in memory
# use FactoryGirl.create to persist it in the app"s database.
describe Contact do
# Factory Validation
  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end
# ================ CONTACT VALIDATION ================
  it "is valid with a firstname, lastname, and email" do
        contact = build(:contact,
      firstname: "Aaron",
      lastname: "Summer",
      email: "tester@example.com")
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    # create used here to persist the contact in the database
    create(:contact,
      email: "myemail@mail.com"
    )
    contact = build(:contact,
      email: "myemail@mail.com"
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end

  # =================== instance method ===================
  it "returns a contact's full name as a string" do
    contact = build(:contact, 
        firstname: "Joseph", 
        lastname: "Joestar",
    ) 

    expect(contact.name).to eq "Joseph Joestar"
  end

  # ==================== Query Tests =====================
  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact,
        firstname: "John",
        lastname: "Smith",
        email: "jsmith@example.com"
      )
      @jones = create(:contact,
        firstname: "Tim",
        lastname: "Jones",
        email: "tjones@example.com"
      )
      @johnson = create(:contact,
        firstname: "John",
        lastname: "Johnson",
        email: "jjohnson@example.com"
      )
    end

    context "with matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "with non-matching letters" do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end

  end
end
