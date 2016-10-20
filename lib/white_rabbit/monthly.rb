# frozen_string_literal: true

module WhiteRabbit
  module Monthly

    def self.next_month(year, month, day)
      return  Date.new(year + 1, 1, day) if month == 12
      Date.new(year, month + 1, day)
    end

    def self.prev_month(year, month, day)
      return Date.new(year - 1, 12, day) if month == 1
      Date.new(year, month - 1, day)
    end

    def self.beginning_of(year, month, closing_date: nil)
      return Date.new(year, month, 1) if closing_date.nil?
      prev_month(year, month, closing_date) + 1
    end

    def self.end_of(year, month, closing_date: nil)
      return Date.new(year, month, closing_date) unless closing_date.nil?
      next_month(year, month, 1) - 1
    end

    def self.term(year, month, closing_date: nil)
      first = beginning_of(year, month, closing_date: closing_date)
      last = end_of(year, month, closing_date: closing_date)
      first..last
    end

    %w(
      sunday monday tuesday wednesday thursday friday saturday
    ).each_with_index do |weekday, wday|
      %w(first second third fourth fifth).each_with_index do |nth, week|
        class_eval <<-METHODS
          def self.#{nth}_#{weekday}_of(year, month)
            first = Date.new(year, month, 1)
            wday_offset = (7 - first.wday + #{wday}) % 7
            week_offset = 7 * #{week}
            first + (wday_offset + week_offset)
          end
        METHODS
      end
    end
  end
end
