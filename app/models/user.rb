class User < ActiveRecord::Base
has_one :user_profile
has_many :user_projects
has_many :projects, :through => :user_projects
has_one :user_address, :through => :user_profile, :source => :address

attr_accessor :password

 attr_accessible :name , :email ,:password , :password_confirmation

 validates :name, :presence   => true ,
                  :length     => { :maximum => 50 },
                  :uniqueness => true

 validates :email, :presence   => true ,
                   :format     => { :with => /(\A[\w.]+[@][a-zA-Z0-9]+[.][a-zA-Z]{2,3}\z)/i} ,
                   :uniqueness => true

 # email_regex =  /(\A[a-zA-Z0-9]+[@][a-zA-Z]+[.][a-zA-Z]{2,3}\z)/i ou ((\A[\w.]+[@][a-zA-Z0-9]+[.][a-zA-Z]{2,3}\z))

 validates  :password , :presence=> true,
                        :confirmation => true,
                        :length => { :within => 8..40 }
 #validates :salt, :presence=> true

 before_save :encrypt_password

 def has_password?(submitted_password)
   encrypted_password == encrypt(submitted_password)
 end
  def has_profile?
     if self.user_profile==nil
       return false
     else
       return true
     end
  end
 private

 def encrypt_password
   self.salt = make_salt if new_record?
   self.encrypted_password = encrypt(password)
 end


 def encrypt(string)
   secure_hash("#{salt}--#{string}")
 end

 def make_salt
   secure_hash("#{Time.now.utc}--#{password}")
 end

 def secure_hash(string)
   Digest::SHA2.hexdigest(string)
 end

 def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
 end

 def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
 end

end
