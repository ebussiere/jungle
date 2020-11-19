require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with name, email, password, password_confirmation" do
      @user = User.create(name: "Eddy Bussiere", email: "ebussiere@embtech.ca", password: "password", 
        password_confirmation: "password"
        ) 
      expect(@user).to be_valid
    end
     
    it "is not valid with out a name" do
      @user = User.create(name: nil, email: "eddy@embtech.ca", password: "password", 
      password_confirmation: "password"
      )  
      expect(@user).to_not be_valid
    end

    it "is not valid with out an email" do
      @user = User.create(name: "Eddy Bussiere", email: nil, password: "password", 
      password_confirmation: "password"
      )  
      expect(@user).to_not be_valid
    end
    
    it "is not valid with out a password" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: nil, 
      password_confirmation: "password"
      )  
      expect(@user).to_not be_valid
    end

    it "is not valid with out a password_confirmation" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
      password_confirmation: nil
      )  
      expect(@user).to_not be_valid
    end

    it "is not valid with out a password and password_confirmation matching" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
      password_confirmation: "passw0rd"
      )  
      expect(@user).to_not be_valid
    end

    it "is not valid with the same email with different casesin the data" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
        password_confirmation: "password"
        )  

      @user1 = User.create(name: "Eddy Bussiere", email: "Eddy@embtech.ca", password: "passwordb", 
        password_confirmation: "passwordb"
        ) 
      expect(@user).to be_valid  
      expect(@user1).to_not be_valid
    end
 
    it "is not valid with password less than 4 characters" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "p", 
        password_confirmation: "p"
        )  
        expect(@user).to_not be_valid
     
    end 
  end

  
  describe '.authenticate_with_credentials' do
    it "is valid with a valid email and password" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
      password_confirmation: "password"
      )
      @user1 = User.authenticate_with_credentials("eddy@embtech.ca", "password")
      expect(@user1).to be_truthy
    end 

    it "is not valid without a password" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
        password_confirmation: "password"
        )
        @user1 = User.authenticate_with_credentials("eddy@embtech.ca", nil)
        expect(@user1).to be_falsey
    end

    it "is not valid without an email" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
        password_confirmation: "password"
        )
        @user1 = User.authenticate_with_credentials(nil, "password")
        expect(@user1).to be_falsey
    end

    it "is not valid with wrong email and correct password" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
        password_confirmation: "password"
        )
        @user1 = User.authenticate_with_credentials("ebussiere@shaw.ca", "password")
        expect(@user1).to be_falsey
    end

    it "is not valid with correct email and wrong password" do
      @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
        password_confirmation: "password"
        )
          @user1 = User.authenticate_with_credentials("eddy@embtech.ca", "X")
        expect(@user1).to be_falsey
    end

    it "is valid with spaces before and after email" do     
    @user = User.create(name: "Eddy Bussiere", email: "eddy@embtech.ca", password: "password", 
      password_confirmation: "password"
      )
        result = User.authenticate_with_credentials(" eddy@embtech.ca ", "password")
      expect(result).to be_truthy
    end
  end
end
