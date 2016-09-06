class Building  < ActiveRecord::Base
	validates :reference, presence: true, uniqueness: true
	validates :address, presence: true
	validates :zip_code, presence: true
	validates :city, presence: true
	validates :country, presence: true
	validates :manager_name, presence: true

  VERSIONABLE = [ :manager_name ]
  include Versionable

end