module Zombieland
  class Object
    attr_reader :x, :y, :type

    def initialize(x:, y:, type:)
      @x    = x
      @y    = y
      @type = type
    end

    def zombie?
      type == :zombie
    end

    def creature?
      type == :creature
    end
  end
end
