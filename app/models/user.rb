class User < ActiveRecord::Base
    #destroys the article if the user who created it is destroyed
    has_many :articles, dependent: :destroy
    
    #take the email and saves it in a lower case form to the database
    before_save {self.email = email.downcase}
    #username check, uniqueness with case sensitive, avoid Jo and jo as 2 users.
    validates :username, presence: true, uniqueness: {case_sensitive: false }, 
    length: {minimum: 3, maximum: 25}   
    
    # This a Rugular regular expresion to check if the input can be a email. Check Rugular.com
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
    has_secure_password
end
