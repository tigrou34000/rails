class ArticleTranslation < ApplicationRecord
	self.primary_key = :id
	belongs_to :article
	has_many :lang
end