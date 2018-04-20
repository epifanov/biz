module Biz
  module Periods
    class Linear < SimpleDelegator

      def initialize(intervals, shifts)
        @intervals = intervals.to_enum
        @shifts    = shifts.to_enum

        super(periods)
      end

      protected

      attr_reader :intervals,
                  :shifts

      private

      def periods
        Enumerator.new do |yielder|
          loop do
            intervals.next and next if intervals.peek.date == shifts.peek.date_in_timezone

            yielder << begin
              eligible_periods
                .sort_by { |series| series.peek.date }
                .first
                .next
                .to_time_segment
            end
          end

          loop do yielder << intervals.next.to_time_segment end
        end
      end

      def eligible_periods
        @eligible_periods ||= [intervals, shifts]
      end

    end
  end
end
