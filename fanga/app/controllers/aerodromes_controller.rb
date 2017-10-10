class AerodromesController < ApplicationController


	skip_before_action :authenticate_request


    swagger_path '/aerodromes/' do
	    operation :get do
	      key :summary, 'lists aerodromes by ID'
	      key :description, 'Returns all aerodromes if the user has access'
	      key :operationId, 'findAerodromes'
	      key :tags, [
	        'aerodromes'
	      ]
	      parameter do
	        key :name, :lat
	        key :in, :query
	        key :description, 'latitude point'
	        key :required, true
	        key :type, :integer
	      end
	       parameter do
	        key :name, :lon
	        key :in, :query
	        key :description, 'longitude point'
	        key :required, true
	        key :type, :integer
	      end
	       parameter do
	        key :name, :ray
	        key :in, :query
	        key :description, 'ray where we have to search aerodromes'
	        key :required, true
	        key :type, :string
	      end
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def index
		#render json: Town.auto_complete(params[:q])
		require 'hashie'
		aerodrome = Hashie::Mash.new Aerodrome.around_town(params[:lat], params[:lon],params[:ray])
		render json: aerodrome.hits.hits.map {|k| k._source.merge({ :distance => k['sort'][0] }) }
	end



	 swagger_path '/aerodromes/' do
	    operation :post do
	      key :summary, 'create aerodromes'
	      key :description, 'add in bdd and elasticsearch all aerodrome from a remote file (http://www.jprendu.fr/aeroweb/_private/22_Espace_GPS/gpx/lfa1705.gpx for france) content lon , lat, code_loc, name_loc, type_loc, countries_id '
	      key :operationId, 'createAerodromes'
	      key :tags, [
	        'aerodromes'
	      ]
	      response 200 do
	        key :description, 'aerodromes response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def create
		require 'open-uri'
		Aerodrome.__elasticsearch__.create_index! force: true
		documents = Nokogiri::XML(open("http://www.jprendu.fr/aeroweb/_private/22_Espace_GPS/gpx/lfa1705.gpx"))
		documents.xpath("//xmlns:wpt").each do |doc|
			lon, lat, code, name = nil
		 	lon = doc.xpath('@lon').to_s.to_f
		 	lat = doc.xpath('@lat').to_s.to_f
		 	doc.children.each do |child|
		      case child.name
			       when 'name'  
			          code = child.text
			       when 'cmt'
			          name = child.text
		       end
		    end
		   	loc =  Aerodrome.new( :lon => lon, :lat => lat, :code_loc => code, :name_loc => name, :type_loc => 1, :countries_id => 1)
		   	loc.save
		end
	end	

end