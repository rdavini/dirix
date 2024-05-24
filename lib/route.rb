require 'google_distance_matrix'
require 'httparty'
require 'addressable'

module Route
  class Tsp
      #refactor function Google module should be called
      def get_shortest_path src, orders
        Rails.logger.info "Year: #{Time.now.year}"
          matrix = GoogleDistanceMatrix::Matrix.new

          src_address = GoogleDistanceMatrix::Place.new address: src
          matrix.origins << src_address
          matrix.destinations << src_address
          orders.each do |order|
              dest= GoogleDistanceMatrix::Place.new address: order.address.address
              matrix.origins << dest
              matrix.destinations << dest
          end

          matrix.configure do |config|
              config.mode = 'driving'
              config.avoid = 'tolls'

              config.google_api_key = ENV["GOOGLE_MAPS_KEY"]
          end

          distance_matrix, points = parse_distance_matrix(matrix.data)

          path = shortest_path(distance_matrix)

          final_path = Array.new

          path[0].each{|p| final_path << points[p]}

          return get_route(final_path), path[1]
      end

      private
      def shortest_path distance_matrix
        tsp_bruteforce distance_matrix
      end

      def tsp_held_karp(distance_matrix)
        num_cities = distance_matrix.length
        memo = {}
      
        # Helper function for recursive dynamic programming
        dp = lambda do |mask, last|
          return 0 if mask == (1 << num_cities) - 1
      
          # Check if the result is memoized
          return memo[[mask, last]] if memo.key?([mask, last])
      
          result = Float::INFINITY
          next_city = nil
      
          (0...num_cities).each do |city|
            # Skip already visited cities
            next if (mask & (1 << city)) != 0
      
            new_mask = mask | (1 << city)
            subproblem_result = distance_matrix[last][city] + dp.call(new_mask, city)
      
            if subproblem_result < result
              result = subproblem_result
              next_city = city
            end
          end
      
          # Memoize the result
          memo[[mask, last]] = [result, next_city]
          return result
        end
      
        # Start the dynamic programming recursion
        result, next_city = memo[[1, 0]] = [dp.call(1, 0), nil]
      
        # Reconstruct the optimal path
        optimal_path = [0]
      
        (1...num_cities).each do |_|
          optimal_path.push(next_city)
          mask = (1 << next_city) | (1 << optimal_path.last)
          _, next_city = memo[[mask, optimal_path.last]]
        end
      
        return optimal_path, result
      end

      def get_route final_path
        url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{final_path[0]}&destination=#{final_path[0]}&waypoints=#{final_path[1..-1].join('%7C')}&key=#{ENV['GOOGLE_MAPS_KEY']}"
        response = HTTParty.get(Addressable::URI.parse(url).display_uri.to_s)

        if response.success?
          puts "Request successful! Response body: #{response.body}"
        else
          puts "Request failed with status code #{response.code}"
        end
        ret_routes = []
        
        JSON.parse(response.body)["routes"].first["legs"].each_with_index do |routes, index|
          legs = []

          legs << ret_routes.last[-1] if index > 0
          
          routes["steps"].each do |route|
            legs << route["end_location"]
          end
          
          ret_routes << legs
        end

        return ret_routes
      end

      def tsp_bruteforce(distance_matrix)
        num_cities = distance_matrix.length
        all_cities = (0...num_cities).to_a
      
        # Generate all possible permutations of cities
        all_permutations = all_cities.permutation.to_a
      
        # Initialize variables to track the best tour and its length
        best_tour = nil
        best_length = Float::INFINITY
      
        # Iterate through all permutations and calculate the tour length
        all_permutations.each do |permutation|
          current_length = calculate_tour_length(permutation, distance_matrix)
      
          # Update the best tour if the current one is shorter
          if current_length < best_length
            best_length = current_length
            best_tour = permutation
          end
        end
      
        return best_tour, best_length
      end
      
      def calculate_tour_length(tour, distance_matrix)
        total_length = 0
      
        # Calculate the total length of the tour based on the distance matrix
        (0...tour.length - 1).each do |i|
          total_length += distance_matrix[tour[i]][tour[i + 1]]
        end
      
        # Add the distance from the last city back to the starting city
        total_length += distance_matrix[tour.last][tour.first]
      
        return total_length
      end

      def parse_distance_matrix data
        dim= data.count
        matrix = Array.new(dim) { Array.new(dim) }
        points = Array.new
        data.each_with_index do |row, i|
            row.each_with_index do |col, j|
                matrix[i][j] = col.distance_in_meters
                points << col.origin.address if i==j
            end
        end

        return matrix, points
      end
    end
  end