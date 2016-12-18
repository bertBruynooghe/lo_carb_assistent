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
    hypo = relation.select{ |bsr| bsr.value < 65 }
    normal = relation.select{ |bsr| 65 <= bsr.value && bsr.value <= 120 }
    hyper = relation.select { |bsr| 120 < bsr.value }

    hypo = Hash[hypo.map{ |bsr| [bsr.read_time, bsr.value] }]
    normal = Hash[normal.map{ |bsr| [bsr.read_time, bsr.value] }]
    hyper = Hash[hyper.map{ |bsr| [bsr.read_time, bsr.value] }]
    Graph.new([ colorSetting('red').merge(name: '<65', data: hypo),
                colorSetting('lime').merge(name: 'normaal', data: normal),
                colorSetting('orange').merge(name: '>120', data: hyper),
                { data: { end_datetime - 1.days => 65, end_datetime => 65}, library: { spanGaps: true, pointRadius: 0, borderColor: 'silver' } },
                { data: { end_datetime - 1.days => 120, end_datetime => 120}, library: { spanGaps: true, pointRadius: 0, borderColor: 'silver' } }
              ])
  end

  def self.colorSetting(color)
    { library: { borderColor: color, pointBorderColor: color, pointBackgroundColor: color, backgroundColor: color } }
  end

end
