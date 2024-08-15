require 'httparty'
require 'google_distance_matrix'

module Google
    class DistanceAPI

        # origins:String 
        # destinations:String
        def self.get_distance_matrix origins, destinations
            return nil if origins.nil? || destinations.nil?
            matrix = GoogleDistanceMatrix::Matrix.new

            src_address = GoogleDistanceMatrix::Place.new address: origins

            matrix.origins << src_address
            
            dest= GoogleDistanceMatrix::Place.new address: destinations
            matrix.destinations << dest
  
            matrix.configure do |config|
                config.mode = 'driving'
                config.avoid = 'tolls'
  
                config.google_api_key = ENV["GOOGLE_MAPS_KEY"]
            end
  
            return matrix.data.first.first.distance_in_meters
        end
    end

    class GeocodingAPI
        def self.convert address
            url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{ENV['GOOGLE_MAPS_KEY']}"
            response = HTTParty.get(Addressable::URI.parse(url).display_uri.to_s)
            
            if response.success?
              puts "Request successful! Response body: #{response.body}"
            else
              puts "Request failed with status code #{response.code}"
            end
            return response["results"].first["geometry"]["location"]
        end
    end
end