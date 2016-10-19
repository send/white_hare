require "spec_helper"

describe WhiteRabbit::Monthly do
  subject(:mod) { WhiteRabbit::Monthly }

  describe '.next_month' do
    it { expect(mod.next_month(2016, 5, 4)).to eq Date.new(2016, 6, 4) }
    it { expect(mod.next_month(2016, 12, 4)).to eq Date.new(2017, 1, 4) }
  end

  describe '.prev_month' do
    it { expect(mod.prev_month(2016, 5, 4)).to eq Date.new(2016, 4, 4) }
    it { expect(mod.prev_month(2016, 1, 4)).to eq Date.new(2015, 12, 4) }
  end

  describe '.beginning_of' do
    it { expect(mod.beginning_of(2016, 3)).to eq Date.new(2016, 3, 1) }
    it do
      expect(mod.beginning_of(2016, 3, closing_date: 20))
        .to eq Date.new(2016, 2, 21)
    end
  end

  describe '.end_of' do
    it { expect(mod.end_of(2016, 2)).to eq Date.new(2016, 2, 29) }
    it do
      expect(mod.end_of(2016, 2, closing_date: 20)) .to eq Date.new(2016, 2, 20)
    end
  end

  describe '.term' do
    it do
      expect(mod.term(2016, 2)).to eq Date.new(2016, 2, 1)..Date.new(2016, 2, 29)
    end
    it do
      expect(mod.term(2016, 3, closing_date: 20))
        .to eq Date.new(2016, 2, 21)..Date.new(2016, 3, 20)
    end
  end
end
