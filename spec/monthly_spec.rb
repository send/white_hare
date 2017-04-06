# frozen_string_literal: true
require "spec_helper"

describe WhiteHare::Monthly do
  subject(:mod) { WhiteHare::Monthly }

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

  context 'evaled methods' do
    describe '.first_saturday_of' do
      it { expect(mod.first_saturday_of(2016, 10)).to eq Date.new(2016, 10, 1) }
    end

    describe '.second_friday_of' do
      it { expect(mod.second_friday_of(2016, 9)).to eq Date.new(2016, 9, 9) }
    end

    describe '.third_thursday_of' do
      it { expect(mod.third_thursday_of(2016, 8)).to eq Date.new(2016, 8, 18) }
    end

    describe '.fourth_wednesday_of' do
      it { expect(mod.fourth_wednesday_of(2016, 7)).to eq Date.new(2016, 7, 27) }
    end

    describe '.fifth_sunday_of' do
      it { expect(mod.fifth_sunday_of(2016, 5)).to eq Date.new(2016, 5, 29) }
    end

    describe '.first_monday_of' do
      it { expect(mod.first_monday_of(2016, 4)).to eq Date.new(2016, 4, 4) }
    end

    describe '.second_tuesday_of' do
      it { expect(mod.second_tuesday_of(2016, 3)).to eq Date.new(2016, 3, 8) }
    end
  end

  context 'refinement Date' do
    using WhiteHare::Monthly

    describe '.next_month' do
      it { expect(Date.new(2016, 5, 4).next_month).to eq Date.new(2016, 6, 4) }
    end

    describe '.prev_month' do
      it { expect(Date.new(2016, 1, 4).prev_month).to eq Date.new(2015, 12, 4) }
    end

    describe '.beginning_of_monthly' do
      it do
        expect(Date.new(2016, 3, 10).beginning_of_monthly(20))
          .to eq Date.new(2016, 2, 21)
      end
    end
    
    describe '.end_of_monthly' do
      it { expect(Date.new(2016, 2, 15).end_of_monthly).to eq Date.new(2016, 2, 29) }
    end

    describe '.monthly_term' do
      it do
        expect(Date.new(2016, 3, 10).monthly_term(20))
          .to eq Date.new(2016, 2, 21)..Date.new(2016, 3, 20)
      end

    end

    describe '.first_saturday' do
      it { expect(Date.new(2016, 10, 5).first_saturday).to eq Date.new(2016, 10, 1) }
    end

    describe '.first_saturday?' do
      it { expect(Date.new(2016, 10, 1).first_saturday?).to be true }
      it { expect(Date.new(2016, 10, 9).first_saturday?).to be false }
    end

    describe '.second_friday' do
      it { expect(Date.new(2016, 9, 10).second_friday).to eq Date.new(2016, 9, 9) }
    end

    describe '.second_friday' do
      it { expect(Date.new(2016, 9, 9).second_friday?).to be true }
      it { expect(Date.new(2016, 9, 10).second_friday?).to be false }
    end

    describe '.third_thursday' do
      it { expect(Date.new(2016, 8, 10).third_thursday).to eq Date.new(2016, 8, 18) }
    end

    describe '.third_thursday_' do
      it { expect(Date.new(2016, 8, 18).third_thursday?).to be true }
      it { expect(Date.new(2016, 8, 11).third_thursday?).to be false }
    end

    describe '.fourth_wednesday' do
      it { expect(Date.new(2016, 7, 5).fourth_wednesday).to eq Date.new(2016, 7, 27) }
    end

    describe '.fourth_wednesday?' do
      it { expect(Date.new(2016, 7, 27).fourth_wednesday?).to be true }
      it { expect(Date.new(2016, 7, 5).fourth_wednesday?).to be false }
    end

    describe '.fifth_sunday' do
      it { expect(Date.new(2016, 5, 18).fifth_sunday).to eq Date.new(2016, 5, 29) }
    end

    describe '.fifth_sunday?' do
      it { expect(Date.new(2016, 5, 29).fifth_sunday?).to be true }
      it { expect(Date.new(2016, 5, 18).fifth_sunday?).to be false }
    end

    describe '.first_monday' do
      it { expect(Date.new(2016, 4, 28).first_monday).to eq Date.new(2016, 4, 4) }
    end

    describe '.first_monday?' do
      it { expect(Date.new(2016, 4, 4).first_monday?).to be true }
      it { expect(Date.new(2016, 4, 28).first_monday?).to be false }
    end

    describe '.second_tuesday' do
      it { expect(Date.new(2016, 3, 31).second_tuesday).to eq Date.new(2016, 3, 8) }
    end

    describe '.second_tuesday?' do
      it { expect(Date.new(2016, 3, 8).second_tuesday?).to be true }
      it { expect(Date.new(2016, 3, 31).second_tuesday?).to be false }
    end
  end
end
