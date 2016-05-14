module Zombieland
  class Workflow
    def self.run(input_file_path:, tunnelling_wall: false)
      game_input_data = Transformer.new(File.new(input_file_path)).game_input_data

      game = Game.new(
        map:                   Zombieland::Models::Map.new(dimensions: game_input_data[:dimensions]),
        zombies_coordinates:   game_input_data[:zombies_coordinates],
        creatures_coordinates: game_input_data[:creatures_coordinates],
        zombie_movements:      game_input_data[:zombie_movements]
      )

      game.play(tunnelling_wall: tunnelling_wall)

      print Presenter.new(game).present
    end
  end
end
