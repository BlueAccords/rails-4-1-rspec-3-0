require "rails_helper"

# USe FactoryGirl.build to store a test object in memory
# use FactoryGirl.create to persist it in the app"s database.
describe Contact do
# Factory Validation
  it "has a valid factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end
# ================ CONTACT VALIDATION ================
  it "is valid with a firstname, lastname, and email" do
        contact = Contact.new(
      firstname: "Aaron",
      lastname: "Summer",
      email: "tester@example.com")
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    contact = FactoryGirl.build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
    contact = FactoryGirl.build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    contact = FactoryGirl.build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    Contact.create(
      firstname: "Billy", lastname: "Jones",
      email: "myemail@mail.com"
    )
    contact = Contact.new(
      firstname: "Kevin", lastname: "King",
      email: "myemail@mail.com"
    )
    contact.valid?
    expect(contact.errors[:email]).to include("has already been taken")
  end

  # =================== instance method ===================
  it "returns a contact's full name as a string" do
    contact = FactoryGirl.build(:contact, 
        firstname: "Joseph", 
        lastname: "Joestar",
    )

    expect(contact.name).to eq "Joseph Joestar"
  end

  # ==================== Query Tests =====================
  describe "filter last name by letter" do
    before :each do
      @smith = Contact.create(
        firstname: "John",
        lastname: "Smith",
        email: "jsmith@example.com"
      )
      @jones = Contact.create(
        firstname: "Tim",
        lastname: "Jones",
        email: "tjones@example.com"
      )
      @johnson = Contact.create(
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
