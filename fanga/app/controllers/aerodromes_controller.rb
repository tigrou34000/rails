class AerodromesController < ApplicationController
	skip_before_action :authenticate_request

	def index
		#render json: Town.auto_complete(params[:q])
		require 'hashie'
		aerodrome = Hashie::Mash.new Aerodrome.around_town(params[:lat], params[:lon],params[:ray])
		render json: aerodrome.hits.hits.map {|k| k._source.merge({ :distance => k['sort'][0] }) }

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