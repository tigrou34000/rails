class TownsController < ApplicationController
	skip_before_action :authenticate_request

	def index
		render json: Town.auto_complete(params[:q])
	end

	def show
		render json: Town.find(params[:id]);
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