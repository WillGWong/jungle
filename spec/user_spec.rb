require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { described_class.new(
      name: "Bob",
      password: "some_password",
      password_confirmation: "some_password",
      email: "john@doe.com") }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without matching passwords" do
      subject.password = "wrong_password"
      expect(subject).to_not be_valid
    end

    it "is not valid with a short password" do
      subject.password = "hi"
      subject.password_confirmation = "hi"
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) { described_class.create!(
      name: "Bob",
      password: "some_password",
      password_confirmation: "some_password",
      email: "john@doe.com") }
    subject {User.authenticate_with_credentials("john@doe.com", "some_password")}
      
    context "logs in with valid email and password" do
      it "returns user" do
       expect(subject.email).to eq "john@doe.com"
      end
    end

    context "fails to log in with wrong password" do
      subject {User.authenticate_with_credentials("john@doe.com", "wrong_password")}
      it "returns nil" do
        expect(subject).to be_nil
      end
    end
    
    context "logs in when there is whitespace in the email field" do
      subject {User.authenticate_with_credentials("      john@doe.com", "some_password")}
      it "returns user" do
        expect(subject.email).to eq "john@doe.com"
      end
    end

    context "logs in when the casing is wrong" do
      subject {User.authenticate_with_credentials("JoHn@doE.com", "some_password")}
      it "returns user" do
        expect(subject.email).to eq "john@doe.com"
      end
    end


  end  
end
