class User < ActiveRecord::Base
  before_validation :email_sanitize
    validates :name, presence: true
    validates :email, presence: true
    validates :email,
              format: { with: /\A^(.+)@(.+)$\z/, message: "Email invalid"  },
                        uniqueness: true,
                        length: { minimum: 4, maximum: 254 }         
    validates :password, presence: true, confirmation: true,
    length: { minimum: 4, maximum: 254 }
  
    validates :password_confirmation, presence: true
    has_secure_password
  
    
    def self.authenticate_with_credentials(email, password) 
     if email && password
      @user = User.find_by_email(email.downcase.strip)
      # If the user exists AND the password entered is correct.
        if @user && @user.authenticate(password)
          return @user
        end
      end
    end
  
    private
    def email_sanitize 
      if email
      email.downcase!
      email.strip
      end
    end
  
  
  end
