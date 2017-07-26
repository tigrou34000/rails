class ArticleToCategory < ApplicationRecord
	self.primary_key = :id
	has_many :category
	has_many :article
end