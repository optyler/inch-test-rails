class Person < ActiveRecord::Base
  validates :reference, presence: true, uniqueness: true
  validates :address, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :home_phone_number, presence: true
  validates :mobile_phone_number, presence: true
  validates :email, presence: true

  VERSIONABLE = [ :email, :mobile_phone_number, :home_phone_number, :address ]
  include Versionable

end