require 'spec_helper'

RSpec.describe Zombieland::Object do
  subject do
    described_class.new(
      x:    1,
      y:    1,
      type: :creature,
      map:  Zombieland::Map.new(dimensions: 4)
    )
  end

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

    it do
      subject.x = -1
      expect(subject.x).to eq(1)
    end

    it do
      subject.x = 8
      expect(subject.x).to eq(1)
    end

    it do
      subject.y = -1
      expect(subject.y).to eq(1)
    end

    it do
      subject.y = 8
      expect(subject.y).to eq(1)
    end
  end

  describe '#move' do
    describe 'DOWN' do
      before { subject.move('D') }

      its(:x) { is_expected.to eq(1) }
      its(:y) { is_expected.to eq(2) }
    end

    describe 'UP' do
      before { subject.move('U') }

      its(:x) { is_expected.to eq(1) }
      its(:y) { is_expected.to eq(0) }
    end

    describe 'LEFT' do
      before { subject.move('L') }

      its(:x) { is_expected.to eq(0) }
      its(:y) { is_expected.to eq(1) }
    end

    describe 'RIGHT' do
      before { subject.move('R') }

      its(:x) { is_expected.to eq(2) }
      its(:y) { is_expected.to eq(1) }
    end

    describe 'invalid movement' do
      it { expect { subject.move('INVALID') }.to raise_exception(Zombieland::Object::MovementException) }
    end
  end
end
