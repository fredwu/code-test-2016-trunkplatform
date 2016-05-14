module Zombieland
  class Game
    attr_reader :map, :zombies_coordinates, :creatures_coordinates, :zombie_movements

    def initialize(map:, zombies_coordinates:, creatures_coordinates:, zombie_movements:)
      @map                   = map
      @zombies_coordinates   = zombies_coordinates
      @creatures_coordinates = creatures_coordinates
      @zombie_movements      = zombie_movements
    end

    def play(tunnelling_wall: false)
      place_zombies(tunnelling_wall: tunnelling_wall)
      place_creatures(tunnelling_wall: tunnelling_wall)

      while map.unmoved_zombies.any?
        map.unmoved_zombies.each do |zombie|
          zombie_movements.each do |movement|
            zombie.move(movement)
          end
        end
      end
    end

    def zombies_score
      map.zombies.size - 1
    end

    def zombies_positions
      map.zombies.sort_by(&:attacked_at).map { |zombie| [zombie.x, zombie.y] }
    end

    private

    def place_zombies(tunnelling_wall:)
      zombies_coordinates.each do |c|
        map.place(x: c[0], y: c[1], type: :zombie, tunnelling_wall: tunnelling_wall)
      end
    end

    def place_creatures(tunnelling_wall:)
      creatures_coordinates.each do |c|
        map.place(x: c[0], y: c[1], type: :creature, tunnelling_wall: tunnelling_wall)
      end
    end
  end
end
