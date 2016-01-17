require 'rails_helper'

describe Contact do
  it 'is valid with a firstname, lastname, and email' do
    # ================ CONTACT VALIDATION ================
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Summer',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it 'is invalid without a firstname' do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include('can\'t be blank')
  end

  it 'is invalid without a lastname' do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include('can\'t be blank')
  end

  it 'is invalid without an email address' do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include('can\'t be blank')
  end

  it 'is invalid with a duplicate email address' do
    Contact.create(
      firstname: 'Billy', lastname: 'Jones',
      email: 'myemail@mail.com'
    )
    contact = Contact.new(
      firstname: 'Kevin', lastname: 'King',
      email: 'myemail@mail.com'
    )
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end

  # =================== Contact method ===================
  it 'returns a contact\'s full name as a string' do
    contact = Contact.new(firstname: 'Joseph', lastname: 'Joestar',
      email: 'joestars@jojo.com')

    expect(contact.name).to eq 'Joseph Joestar'
  end

  # ==================== Query Tests =====================
  it 'returns a sorted array of results that match' do
    smith = Contact.create(
      firstname: 'John',
      lastname: 'Smith',
      email: 'jsmith@example.com'
    )
    jones = Contact.create(
      firstname: 'Tim',
      lastname: 'Jones',
      email: 'tjones@example.com'
    )
    johnson = Contact.create(
      firstname: 'John',
      lastname: 'Johnson',
      email: 'jjohnson@example.com'
    )
    expect(Contact.by_letter('J')).to eq [johnson, jones]
  end

  it 'omits results that do not match' do
    smith = Contact.create(
      firstname: 'John',
      lastname: 'Smith',
      email: 'jsmith@example.com'
    )
    jones = Contact.create(
      firstname: 'Tim',
      lastname: 'Jones',
      email: 'tjones@example.com'
    )
    johnson = Contact.create(
      firstname: 'John',
      lastname: 'Johnson',
      email: 'jjohnson@example.com'
    )
    expect(Contact.by_letter('J')).to_not include smith
  end
end
