module Biz
  class Shift

    extend Forwardable

    include Comparable

    def initialize(date_in_timezone, time_segment)
      @time_segment = time_segment
      @date_in_timezone = date_in_timezone
    end

    def date
      @date ||= start_time.to_date
    end

    delegate %i[contains? start_time end_time] => :time_segment

    protected

    attr_reader :time_segment

    private

    def <=>(other)
      return unless other.is_a?(self.class)

      time_segment <=> other.time_segment
    end

    public

    attr_reader :date_in_timezone

    def to_time_segment
      time_segment
    end

  end
end
