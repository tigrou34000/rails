require 'elasticsearch/model'

class Aerodrome < ActiveRecord::Base
  
  
	ELASTICSEARCH_MAX_RESULTS = 25

	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks
	include Elasticsearch::Model::Indexing

	settings index: { number_of_shards: 1 , number_of_replicas: 0} do
		mapping do
			indexes :id, type: 'integer', index: :not_analyzed
			indexes :code_loc, type: 'string'
			indexes :name_loc, type: 'string'
			indexes :type_loc, type: 'integer', index: :not_analyzed
			indexes :countries_id, type: 'integer', index: :not_analyzed
			indexes :coordonate_point, type: 'geo_point' 
		end
	end
	def as_indexed_json(_options = {})
		as_json(only: %w(id code_loc name_loc type_loc countries_id))
			.merge(coordonate_point: [lon, lat]
			)
	end

	def self.around_town(lat, lon, ray)
		Aerodrome.__elasticsearch__.client.search  \
		index: Aerodrome.index_name,
		body: 
		{ 
			from: 0,
			size: 15,
			query: {
		        bool: {
		            must: {
		                match_all: {}
		            },
		            filter: {
		                geo_distance: {
		                    distance: "#{ray}km",
		                    coordonate_point: {
		                        lat: lat,
		                        lon: lon
		                    }
		                }
		            }
		        }
		    },

		    "sort": [
		    {
		      _geo_distance: {
		        coordonate_point: { 
		          lat:  lat,
		          lon: lon
		        },
		        order:         "asc",
		        unit:          "km", 
		        distance_type: "plane" 
		      }
		    }
		  ]
		}


	end
end
