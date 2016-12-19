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
    Graph.new([ historic_blood_sugar_readings_data(end_datetime),
                manual_blood_sugar_readings_data(end_datetime),
                carbs_data(end_datetime),
                basal_data(end_datetime),
                indicator_line(end_datetime, 65),
                indicator_line(end_datetime, 120)
              ])
  end



  def self.indicator_line(end_datetime, value)
    {
      data: { end_datetime - 1.days => value, end_datetime => value},
      library: { spanGaps: true, pointRadius: 0, borderColor: 'silver' }
    }
  end

  def self.historic_blood_sugar_readings_data(end_datetime)
    blood_sugar_readings = BloodSugarReading.where('read_time > ?', end_datetime - 1.days)
                                .where('read_time <= ?', end_datetime).where(manual: false)

    # TODO: only put color when new time is written in hash...
    data = { name: 'glucose', data: {}, library: { spanGaps: true } }
    blood_sugar_readings.each do |reading|
      data[:data][reading.read_time] = reading.value
      lib = data[:library]
    end
    data
  end

  def self.manual_blood_sugar_readings_data(end_datetime)
    blood_sugar_readings = BloodSugarReading.where('read_time > ?', end_datetime - 1.days)
                                .where('read_time <= ?', end_datetime).where(manual: true)

    # TODO: only put color when new time is written in hash...
    data = { name: 'glucose', data: {}, library: { spanGaps: true } }
    blood_sugar_readings.each do |reading|
      data[:data][reading.read_time] = reading.value
      lib = data[:library]
    end
    data
  end

  def self.carbs_data(end_datetime)
    meals = Meal.where('consumption_time > ?', end_datetime - 1.days)
                .where('consumption_time <= ?', end_datetime)
    data = { name: 'gKH', data: {},
             library: {
               showLine: false,
               pointStyle: 'triangle',
             } }

    meals.each do |meal|
      data[:data][meal.consumption_time] = meal.carbs
    end
    data
  end

  def self.basal_data(end_datetime)
    insulin_doses = InsulinDose.where('application_time > ?', end_datetime - 1.days)
                               .where('application_time <= ?', end_datetime)
    data = { name: 'E', data: {}, library: { showLine: false, pointStyle: 'triangle' } }
    insulin_doses.each do |insulin_dose|
      data[:data][insulin_dose.application_time] = insulin_dose.dose * 12
    end
    data
  end

  def self.to_color(value)
    if value < 65
      'red'
    elsif value > 120
      'orange'
    else
      'lime'
    end
  end
end
