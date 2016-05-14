module Zombieland
  class Presenter
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def present
      <<-STRING
------------------------------------------------------------
 Zombies score:     #{game.zombies_score}
 Zombies positions: #{game.zombies_positions.map { |pos| pos.join(' ') }.join(', ')}
------------------------------------------------------------
      STRING
    end
  end
end
