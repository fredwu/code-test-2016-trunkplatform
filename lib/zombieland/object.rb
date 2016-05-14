module Zombieland
  class Object
    attr_accessor :x, :y, :type, :tunnelling_wall, :map, :moved, :attacked_at

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
    end

    def zombie?
      type == :zombie
    end

    def creature?
      type == :creature
    end

    def x=(new_x)
      if valid_movement?(new_x)
        @x = new_x
      elsif tunnelling_wall?
        @x = tunnel_coordinate(new_x)
      end

      movement_event
    end

    def y=(new_y)
      if valid_movement?(new_y)
        @y = new_y
      elsif tunnelling_wall?
        @y = tunnel_coordinate(new_y)
      end

      movement_event
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

    def movement_event
      self.moved = true

      attack if zombie?
    end

    def attack
      current_coordinate.creatures.each(&:attacked!)
    end

    def valid_movement?(coordinate)
      map.coordinate_constructs.include?(coordinate)
    end

    def tunnel_coordinate(coordinate)
      if coordinate < map.class::ORIGIN
        map.dimensions + coordinate
      else
        coordinate - map.dimensions
      end
    end

    class MovementException < ::Exception; end
  end
end
