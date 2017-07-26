class Lang < ApplicationRecord
	self.primary_key = :id
	has_many :article_translation, :inverse_of => :Lang
	has_many :category_translation, :inverse_of => :Lang

end