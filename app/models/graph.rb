class Graph
  attr_reader :data
  attr_reader :options

  def self.for_week(start_datetime)
    end_datetime = start_datetime ? (DateTime.iso8601(start_datetime) + 7.days) : DateTime.now
    (0..6).map{ |i| self.graph_for_day(end_datetime - i.days) }
  end

  def initialize(data)
    @data = data
    @options = { max: 500, curve: false, legend: { display: false } }
  end

  private

  def self.graph_for_day(end_datetime)
    relation = BloodSugarReading.where('read_time > ?', end_datetime - 1.days)
                                .where('read_time <= ?', end_datetime)

    glucose = Hash[relation.map{ |bsr| [bsr.read_time, bsr.value] }]
    Graph.new([ colorSetting(glucose.map{ |k, v| to_color(v) }).merge(name: 'glucose', data: glucose),
                indicator_line(end_datetime, 65),
                indicator_line(end_datetime, 120)
              ])
  end

  def self.colorSetting(colors)
    colors.unshift('black')
    { library: {
      borderColor: colors,
      pointBorderColor: colors,
      pointBackgroundColor: colors,
      backgroundColor: colors }
    }
  end

  def self.indicator_line(end_datetime, value)
    {
      data: { end_datetime - 1.days => value, end_datetime => value},
      library: { spanGaps: true, pointRadius: 0, borderColor: 'silver' }
    }
  end

  def self.to_color(value)
    if value < 56
      'red'
    elsif value > 120
      'orange'
    else
      'lime'
    end
  end
end
