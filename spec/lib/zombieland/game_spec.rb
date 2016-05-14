require 'spec_helper'

RSpec.describe Zombieland::Game do
  subject do
    described_class.new(
      map:                   Zombieland::Models::Map.new(dimensions: 4),
      zombies_coordinates:   [[2, 1]],
      creatures_coordinates: [[0, 1], [1, 2], [3, 1]],
      zombie_movements:      ['D', 'L', 'U', 'U', 'R', 'R']
    )
  end

  context 'normal mode' do
    before do
      subject.play
    end

    its(:zombies_score)     { is_expected.to eq(2) }
    its(:zombies_positions) { is_expected.to eq([[3, 0], [2, 1], [2, 0]]) }
  end

  context 'tunnelling wall mode' do
    before do
      subject.play(tunnelling_wall: true)
    end

    its(:zombies_score)     { is_expected.to eq(3) }
    its(:zombies_positions) { is_expected.to eq([[3, 0], [2, 1], [1, 0], [0, 0]]) }
  end
end
