# frozen_string_literal: true

module WhiteHare
  module Monthly
    def self.next_month(year, month, day)
      Date.new(year, month, day) >> 1
    end

    def self.prev_month(year, month, day)
      Date.new(year, month, day) << 1
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
        module_eval <<-METHODS
          def self.#{nth}_#{weekday}_of(year, month)
            first = Date.new(year, month, 1)
            wday_offset = (7 - first.wday + #{wday}) % 7
            week_offset = 7 * #{week}
            first + (wday_offset + week_offset)
          end
        METHODS
      end
    end

    refine Date do
      # Active Support has same methods below.
      unless (
          defined?(DateAndTime::Calculations) &&
          self.included?(DateAndTime::Calculations)
      )
        def next_month
          WhiteHare::Monthly.next_month(year, month, day)
        end

        def prev_month
          WhiteHare::Monthly.prev_month(year, month, day)
        end
      end

      def beginning_of_monthly(closing_date = nil)
        WhiteHare::Monthly.beginning_of(year, month, closing_date: closing_date)
      end

      def end_of_monthly(closing_date = nil)
        WhiteHare::Monthly.end_of(year, month, closing_date: closing_date)
      end

      def monthly_term(closing_date = nil)
        WhiteHare::Monthly.term(year, month, closing_date: closing_date)
      end

      %w(
        sunday monday tuesday wednesday thursday friday saturday
      ).each_with_index do |weekday, wday|
        %w(first second third fourth fifth).each_with_index do |nth, week|
          module_eval <<-METHODS
            def #{nth}_#{weekday}
              WhiteHare::Monthly.#{nth}_#{weekday}_of(year, month)
            end

            def #{nth}_#{weekday}?
              self == #{nth}_#{weekday}
            end
          METHODS
        end
      end
    end
  end
end
