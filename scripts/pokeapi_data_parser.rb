require 'json'
require 'csv'

POKEMON_IN_GAME_IDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 16, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 808, 809] 

class DataLoader

    def initialize(data_directory:)
        @data_directory = data_directory      
        #the pokemon types
        @types_by_id = {}
        #the types for each pokemon by pokemon id
        @pokemon_types_by_id = {}
        #pokemon by id
        @pokemon_by_id = {}
        #pokemon by first letter
        @pokemon_by_first_letter = {}
    end
    
    def load_data_to_json
        load_pokemon_types
        load_pokemon
        store_json
    end

    private

    def load_pokemon_types
        CSV.foreach("#{@data_directory}/types.csv", headers: true) do |row|
            hash = row.to_h
            @types_by_id[hash['id'].to_i] = hash['identifier']
        end

        CSV.foreach("#{@data_directory}/pokemon_types.csv", headers: true) do |row|
            hash = row.to_h
            pokemon_id = hash['pokemon_id'].to_i
            if POKEMON_IN_GAME_IDS.include?(pokemon_id)
                @pokemon_types_by_id[pokemon_id] ||= []
                @pokemon_types_by_id[pokemon_id] << hash['type_id'].to_i
            end
        end
    end

    def load_pokemon
        CSV.foreach("#{@data_directory}/pokemon.csv", headers: true) do |row|
            hash = row.to_h
            pokemon_id = hash['id'].to_i
            if POKEMON_IN_GAME_IDS.include?(pokemon_id)
                types = @pokemon_types_by_id[pokemon_id].map {|type_id| @types_by_id[type_id]}
                pokemon = {id: pokemon_id, name: hash['identifier'], types: types }
                @pokemon_by_id[pokemon[:id]] = pokemon
                start_letter = pokemon[:name][0]
                @pokemon_by_first_letter[start_letter] ||= []
                @pokemon_by_first_letter[start_letter] << pokemon
            end
        end

        @pokemon_by_first_letter.each do |key, value|
            value.sort_by! {|pokemon| pokemon[:name]}
        end

    end

    def store_json
        File.write("pokemon_by_first_letter.json",JSON.generate(@pokemon_by_first_letter))
        File.write("pokemon_by_id.json",JSON.generate(@pokemon_by_id))
        File.write("pokemon_types.json", JSON.generate(@types_by_id))
    end
end

DataLoader.new(data_directory: ARGV[0]).load_data_to_json