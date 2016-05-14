require 'spec_helper'

RSpec.describe Zombieland::Models::Map do
  subject(:map) { described_class.new(dimensions: 4) }

  its(:coordinate_constructs) { is_expected.to eq([0, 1, 2, 3]) }

  describe '4x4 map of coordinates' do
    its(:coordinates) { is_expected.to have(16).items }

    describe 'first coordinate' do
      subject { map.coordinates.first }

      it { is_expected.to be_kind_of(Zombieland::Models::Map::Coordinate) }

      its(:x)   { is_expected.to eq(0) }
      its(:y)   { is_expected.to eq(0) }
      its(:map) { is_expected.to eq(map) }
    end

    describe 'last coordinate' do
      subject { map.coordinates.last }

      it { is_expected.to be_kind_of(Zombieland::Models::Map::Coordinate) }

      its(:x)   { is_expected.to eq(3) }
      its(:y)   { is_expected.to eq(3) }
      its(:map) { is_expected.to eq(map) }
    end
  end

  describe '#coordinate' do
    subject { map.coordinate(x: 1, y: 1) }

    it { is_expected.to be_kind_of(Zombieland::Models::Map::Coordinate) }

    its(:x)   { is_expected.to eq(1) }
    its(:y)   { is_expected.to eq(1) }
    its(:map) { is_expected.to eq(map) }
  end

  describe '#objects_at' do
    subject { map.objects_at(x: 1, y: 1) }

    it { is_expected.to be_empty }
  end

  describe '#zombies' do
    subject { map.zombies }

    before do
      map.place(x: 1, y: 1, type: :zombie)
      map.place(x: 1, y: 1, type: :zombie)
    end

    it { is_expected.to have(2).items }
  end

  describe '#unmoved_zombies' do
    let!(:zombie) { map.place(x: 1, y: 1, type: :zombie) }

    subject { map.unmoved_zombies }

    before do
      map.place(x: 1, y: 1, type: :zombie)
      zombie.moved = true
    end

    it { is_expected.to have(1).item }
  end

  describe '#place' do
    let(:coordinates) { { x: 2, y: 1 } }

    it { expect(map.place(**coordinates, type: :zombie)).to be_kind_of(Zombieland::Models::Object) }

    context 'a zomebie' do
      before do
        map.place(**coordinates, type: :zombie)
      end

      describe 'coordinate' do
        subject { map.coordinate(**coordinates) }

        its(:zombies?)   { is_expected.to be(true) }
        its(:creatures?) { is_expected.to be(false) }
      end

      describe 'objects' do
        subject(:objects) { map.objects_at(**coordinates) }

        it { is_expected.to have(1).item }

        describe 'object' do
          subject { objects.first }

          its(:type) { is_expected.to eq(:zombie) }
        end
      end
    end

    context 'a zomebie and a creature' do
      before do
        map.place(**coordinates, type: :zombie)
        map.place(**coordinates, type: :creature)
      end

      describe 'coordinate' do
        subject { map.coordinate(**coordinates) }

        its(:zombies?)   { is_expected.to be(true) }
        its(:creatures?) { is_expected.to be(true) }
      end

      describe 'objects' do
        subject(:objects) { map.objects_at(**coordinates) }

        it { is_expected.to have(2).items }

        describe 'first object' do
          subject { objects.first }

          its(:type) { is_expected.to eq(:zombie) }
        end

        describe 'second object' do
          subject { objects.last }

          its(:type) { is_expected.to eq(:creature) }
        end
      end
    end
  end
end
