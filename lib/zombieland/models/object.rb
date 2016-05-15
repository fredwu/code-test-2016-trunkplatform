module Zombieland
  module Models
    class Object
      attr_accessor :x, :y, :type, :tunnelling_wall, :map, :moved, :attacked_at
      attr_reader :movement

      alias moved? moved
      alias tunnelling_wall? tunnelling_wall

      def initialize(x:, y:, type: nil, tunnelling_wall: false, map:)
        @x               = x
        @y               = y
        @type            = type
        @tunnelling_wall = tunnelling_wall
        @map             = map
        @moved           = false
        @attacked_at     = Time.now
        @movement        = Movement.new(self)
      end

      def zombie?
        type == :zombie
      end

      def creature?
        type == :creature
      end

      def x=(new_x)
        @x = movement.to(new_x) || @x

        post_movement_event
      end

      def y=(new_y)
        @y = movement.to(new_y) || @y

        post_movement_event
      end

      def move(direction)
        case direction
        when 'D' then self.y += 1
        when 'U' then self.y -= 1
        when 'L' then self.x -= 1
        when 'R' then self.x += 1
        else raise MovementException, 'Unrecognised direction!'
        end
      end

      def attacked!
        self.type        = :zombie
        self.attacked_at = Time.now
      end

      private

      def current_coordinate
        map.coordinate(x: x, y: y)
      end

      def post_movement_event
        self.moved = true

        attack if zombie?
      end

      def attack
        current_coordinate.creatures.each(&:attacked!)
      end
    end
  end
end
