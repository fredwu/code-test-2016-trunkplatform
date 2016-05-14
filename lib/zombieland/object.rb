module Zombieland
  class Object
    attr_accessor :x, :y, :type, :map

    def initialize(x:, y:, type: nil, map:)
      @x    = x
      @y    = y
      @type = type
      @map  = map
    end

    def zombie?
      type == :zombie
    end

    def creature?
      type == :creature
    end

    def x=(new_x)
      @x = new_x if map.coordinate_constructs.include?(new_x)
    end

    def y=(new_y)
      @y = new_y if map.coordinate_constructs.include?(new_y)
    end

    def move(direction)
      case direction
      when 'D' then self.y += 1
      when 'U' then self.y -= 1
      when 'L' then self.x -= 1
      when 'R' then self.x += 1
      else raise(MovementException.new('Unrecognised direction!'))
      end
    end

    class MovementException < ::Exception; end
  end
end
