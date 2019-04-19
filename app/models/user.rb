class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :national_id, length: { is: 14 }, uniqueness: true
  validates :password, presence: true, on: :create
  
  def full_name
    return "#{first_name} #{last_name}" unless last_name.nil? 
    ''
  end

  def birth_date
    "#{national_id[5..6]}/#{national_id[3..4]}/#{national_id[0].to_i+17}#{national_id[1..2]}"
  end

  def age
    (Time.now.to_date - birth_date.to_date).to_int/12/30
  end

  def gender
    (national_id[9..12].to_i%2) == 0 ? 'Female' : 'Male'
  end

  def gender? type
    gender.downcase == type.downcase
  end

  def register
    self.password = self.class.hashed_password(password)
    self.save
  end

  def self.hashed_password(password)
    Digest::SHA1.hexdigest(password)
  end

  def self.login(national_id, password)
    self.find_by(national_id: national_id, password: self.hashed_password(password)) || false
  end
end
