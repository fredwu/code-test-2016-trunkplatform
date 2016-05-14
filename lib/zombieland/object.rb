module Zombieland
  class Object
    attr_accessor :x, :y, :type, :map, :moved

    alias_method :moved?, :moved

    def initialize(x:, y:, type: nil, map:)
      @x    = x
      @y    = y
      @type = type
      @map  = map

      @moved = false
    end

    def zombie?
      type == :zombie
    end

    def creature?
      type == :creature
    end

    def x=(new_x)
      if map.coordinate_constructs.include?(new_x)
        @x = new_x

        movement_event
      end
    end

    def y=(new_y)
      if map.coordinate_constructs.include?(new_y)
        @y = new_y

        movement_event
      end
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
      self.type = :zombie
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

    class MovementException < ::Exception; end
  end
end
