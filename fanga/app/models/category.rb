class Category < ApplicationRecord
	self.primary_key = :id
	has_many :article, :through => :article_to_category
	has_many :category_translation, :inverse_of => :category
end