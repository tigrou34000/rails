class Country < ApplicationRecord
	self.primary_key = :id
	has_many :type_location, :inverse_of => :country

end