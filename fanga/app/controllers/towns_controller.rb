class TownsController < ApplicationController
	skip_before_action :authenticate_request

	
	 swagger_path '/towns/' do
	    operation :get do
	      key :summary, 'lists towns by ID'
	      key :description, 'Returns all  town if the user has access'
	      key :operationId, 'findTowns'
	      key :tags, [
	        'town'
	      ]
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def index
		require 'hashie'
		towns = Hashie::Mash.new Town.auto_complete(params[:q])

		render json: towns.hits.hits.map {|k| k._source }
	end


	 swagger_path '/towns/{id}' do
	    operation :get do
	      key :summary, 'Find town by ID'
	      key :description, 'Returns a single town if the user has access'
	      key :operationId, 'findTownrById'
	      key :tags, [
	        'town'
	      ]
	      parameter do
	        key :name, :id
	        key :in, :path
	        key :description, 'ID of town to fetch'
	        key :required, true
	        key :type, :integer
	        key :format, :int64
	      end
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def show
		render json: Town.find(params[:id]);
	end


	 swagger_path '/towns/' do
	    operation :post do
	      key :summary, 'create towns'
	      key :description, 'add in bdd and elasticsearch all towns from a remote file /storage/villes_france.xml or http://sql.sh/ressources/sql-villes-france/villes_france.xml (lon, lat, name, cpt, dep , contries_id)'
	      key :operationId, 'createTowns'
	      key :tags, [
	        'town'
	      ]
	      response 200 do
	        key :description, 'user response'
	      end
	      response :default do
	        key :description, 'unexpected error'
	      end
	    end
	  end
	def create
		Town.__elasticsearch__.create_index! force: true
		documents = Nokogiri::XML(open("./storage/villes_france.xml"))
		documents.xpath("//table").each do |doc|
			lon, lat, dep, name, cpt = nil
			name =  doc.xpath("column[@name='ville_nom_reel']").text
			cpt = doc.xpath("column[@name='ville_code_postal']").text
			dep = doc.xpath("column[@name='ville_departement']").text
			lat =  doc.xpath("column[@name='ville_latitude_deg']").text
			lon =  doc.xpath("column[@name='ville_longitude_deg']").text
			
			towns =  Town.new( :lon => lon, :lat => lat, :name => name, :cpt => cpt, :dep => dep, :countries_id => 1)
		   	towns.save
		end
	end

end