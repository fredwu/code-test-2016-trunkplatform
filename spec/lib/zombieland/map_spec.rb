require 'spec_helper'

RSpec.describe Zombieland::Map do
  subject(:map) { described_class.new(dimensions: 4) }

  describe '4x4 map of coordinates' do
    its(:coordinates) { is_expected.to have(16).items }

    describe 'first coordinate' do
      subject { map.coordinates.first }

      it { is_expected.to be_kind_of(Zombieland::Map::Coordinate) }

      its(:x) { is_expected.to eq(0) }
      its(:y) { is_expected.to eq(0) }
    end

    describe 'last coordinate' do
      subject { map.coordinates.last }

      it { is_expected.to be_kind_of(Zombieland::Map::Coordinate) }

      its(:x) { is_expected.to eq(3) }
      its(:y) { is_expected.to eq(3) }
    end
  end
end
