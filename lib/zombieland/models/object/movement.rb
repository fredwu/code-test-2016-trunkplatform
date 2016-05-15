module Zombieland
  module Models
    class Object
      class Movement
        attr_reader :object

        def initialize(object)
          @object = object
        end

        def to(coordinate)
          if valid_movement?(coordinate)
            coordinate
          elsif object.tunnelling_wall?
            tunnel_coordinate(coordinate)
          end
        end

        private

        def valid_movement?(coordinate)
          object.map.coordinate_constructs.include?(coordinate)
        end

        def tunnel_coordinate(coordinate)
          if coordinate < object.map.class::ORIGIN
            object.map.dimensions + coordinate
          else
            coordinate - object.map.dimensions
          end
        end
      end

      class MovementException < ::Exception; end
    end
  end
end
