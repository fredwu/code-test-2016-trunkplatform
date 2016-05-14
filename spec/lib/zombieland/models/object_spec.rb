require 'spec_helper'

RSpec.describe Zombieland::Models::Object do
  let(:map) { Zombieland::Models::Map.new(dimensions: 4) }

  subject do
    described_class.new(
      x:    1,
      y:    1,
      type: :creature,
      map:  map
    )
  end

  its(:moved?) { is_expected.to be(false) }

  context 'zombie' do
    before do
      subject.type = :zombie
    end

    its(:zombie?)   { is_expected.to be(true) }
    its(:creature?) { is_expected.to be(false) }
  end

  context 'creature' do
    its(:zombie?)   { is_expected.to be(false) }
    its(:creature?) { is_expected.to be(true) }
  end

  describe 'coordinate boundaries' do
    it 'valid x coordinate' do
      subject.x = 2
      expect(subject.x).to eq(2)
    end

    it 'valid y coordinate' do
      subject.y = 2
      expect(subject.y).to eq(2)
    end

    context 'normal' do
      it do
        subject.x = -1
        expect(subject.x).to eq(1)
      end

      it do
        subject.x = 4
        expect(subject.x).to eq(1)
      end

      it do
        subject.y = -1
        expect(subject.y).to eq(1)
      end

      it do
        subject.y = 4
        expect(subject.y).to eq(1)
      end
    end

    context 'tunnelling enabled' do
      before do
        subject.tunnelling_wall = true
      end

      it do
        subject.x = -1
        expect(subject.x).to eq(3)
      end

      it do
        subject.x = 4
        expect(subject.x).to eq(0)
      end

      it do
        subject.y = -1
        expect(subject.y).to eq(3)
      end

      it do
        subject.y = 4
        expect(subject.y).to eq(0)
      end
    end
  end

  describe '#move' do
    context 'valid movements' do
      describe 'DOWN' do
        before { subject.move('D') }

        its(:x)      { is_expected.to eq(1) }
        its(:y)      { is_expected.to eq(2) }
        its(:moved?) { is_expected.to be(true) }
      end

      describe 'UP' do
        before { subject.move('U') }

        its(:x)      { is_expected.to eq(1) }
        its(:y)      { is_expected.to eq(0) }
        its(:moved?) { is_expected.to be(true) }
      end

      describe 'LEFT' do
        before { subject.move('L') }

        its(:x)      { is_expected.to eq(0) }
        its(:y)      { is_expected.to eq(1) }
        its(:moved?) { is_expected.to be(true) }
      end

      describe 'RIGHT' do
        before { subject.move('R') }

        its(:x)      { is_expected.to eq(2) }
        its(:y)      { is_expected.to eq(1) }
        its(:moved?) { is_expected.to be(true) }
      end
    end

    context 'invalid movement' do
      before do
        expect(subject).to_not receive(:movement_event)
      end

      it { expect { subject.move('INVALID') }.to raise_exception(Zombieland::Models::Object::MovementException) }

      its(:moved?) { is_expected.to be(false) }
    end
  end

  describe '#attack' do
    let!(:creature1) { map.place(x: 1, y: 1, type: :creature) }
    let!(:creature2) { map.place(x: 1, y: 1, type: :creature) }

    before do
      subject.send(:attack)
    end

    describe 'creature 1' do
      subject { creature1 }

      its(:zombie?)     { is_expected.to be(true) }
      its(:attacked_at) { is_expected.to be_within(0.01).of Time.now }
    end

    describe 'creature 2' do
      subject { creature2 }

      its(:zombie?)     { is_expected.to be(true) }
      its(:attacked_at) { is_expected.to be_within(0.01).of Time.now }
    end
  end

  describe '#is_attacked!' do
    before do
      subject.type = :creature
      subject.attacked!
    end

    its(:zombie?) { is_expected.to be(true) }
  end

  describe 'move (and trigger the attack if it is a zombie)' do
    let!(:creature) { map.place(x: 2, y: 1, type: :creature) }

    context 'is a zombie' do
      before do
        subject.type = :zombie
        subject.move('R')
      end

      it { expect(creature.zombie?).to be(true) }
    end

    context 'is a creature' do
      before do
        subject.type = :creature
        subject.move('R')
      end

      it { expect(creature.zombie?).to be(false) }
    end
  end
end
