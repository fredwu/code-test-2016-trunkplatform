require 'spec_helper'

RSpec.describe Zombieland::Transformer do
  subject { described_class.new(File.new('example-data/input.txt')) }

  its(:game_input_data) do
    is_expected.to eq(
      dimensions:            4,
      zombies_coordinates:   [[2, 1]],
      creatures_coordinates: [[0, 1], [1, 2], [3, 1]],
      zombie_movements:      ['D', 'L', 'U', 'U', 'R', 'R']
    )
  end
end
