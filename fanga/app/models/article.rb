class Article < ActiveRecord::Base
	self.primary_key = :id
	has_many :category, :through => :article_to_category
	has_many :article_translation
end