
require 'elasticsearch/model'
class Town < ActiveRecord::Base

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	include Elasticsearch::Model::Indexing


	self.primary_key = :id
	ELASTICSEARCH_MAX_RESULTS = 25
	has_one :location
	settings index: { 
			number_of_shards: 1 ,
		      "analysis" => {
		        "analyzer" => {
		          "autocomplete_analyzer" => {
		            "type" => "custom",
		            "tokenizer" => "standard",
		            "filter"    => ["lowercase", "asciifolding", "title_ngram"]
		          }
		        },
		        "filter" => {
		          "title_ngram" => {
		            "type" => "edge_ngram",
		            "min_gram" => 2,
		            "max_gram" => 5
		          }
		        }
		    }
		} do 
		mapping do
			indexes :location, type: 'geo_point' 
			indexes :name, type: 'text' 
			indexes :cpt, type: 'text', index: :not_analyzed 
			indexes :dep, type: 'text', index: :not_analyzed
			indexes :countries_id, type: 'integer', index: :not_analyzed
			indexes :town_suggest, type:'text',  analyzer: 'autocomplete_analyzer'
		end
	end


	def as_indexed_json(_options = {})
		as_json(only: %w(id name cpt dep countries_id))
			.merge(location: {
				lat: lat.to_f, lon: lon.to_f
			}).merge(
				town_suggest: name
			)
	end
	def self.auto_complete(q)
		return nil if q.blank?
		return Town.__elasticsearch__.client.search  \
		index: Town.index_name,
		body: { query: { match: { town_suggest: q.to_s} } }
	end


end