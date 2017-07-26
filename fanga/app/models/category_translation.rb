class CategoryTranslation < ApplicationRecord
	self.primary_key = :id
	belongs_to :category
	has_many :lang
end