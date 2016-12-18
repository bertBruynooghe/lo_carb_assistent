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
    glucose = BloodSugarReading.where('read_time > ?', end_datetime - 1.days)
                                .where('read_time <= ?', end_datetime)

    glucose = Hash[glucose.map{ |bsr| [bsr.read_time, bsr.value] }]


    Graph.new([ colorSetting(glucose.map{ |k, v| to_color(v) }).merge(name: 'glucose', data: glucose),
                carbs_data(end_datetime),
                basal_data(end_datetime),
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

  def self.carbs_data(end_datetime)
    meals = Meal.where('consumption_time > ?', end_datetime - 1.days)
                .where('consumption_time <= ?', end_datetime)
    data = { name: 'gKH', data: {}, library: { pointStyle: 'triangle', pointRadius: [100], pointBackgroundColor: "rgba(255, 0, 0, 0.2)", pointBorderColor: "rgba(255, 0, 0, 0.2)" } }
    meals.each do |meal|
      data[:data][meal.consumption_time] = meal.carbs
      data[:library][:pointRadius] << meal.carbs
    end
    data
  end

  def self.basal_data(end_datetime)
    insulin_doses = InsulinDose.where('application_time > ?', end_datetime - 1.days)
                               .where('application_time <= ?', end_datetime)
    data = { name: 'E', data: {}, library: { pointStyle: 'triangle', pointRadius: [100], pointBackgroundColor: "rgba(0, 255, 0, 0.2)", pointBorderColor: "rgba(0, 255, 0, 0.2)" } }
    insulin_doses.each do |insulin_dose|
      data[:data][insulin_dose.application_time] = insulin_dose.dose
      data[:library][:pointRadius] << (insulin_dose.dose.to_i * 12)
    end
    data
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
