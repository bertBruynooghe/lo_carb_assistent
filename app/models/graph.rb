class Graph
  def self.for_week(start_date)
    start_date = if start_date
      DateTime.iso8601(start_date) + 7.days
    else
      DateTime.now
    end  
    (0..6).map do |i|
      relation = BloodSugarReading.where('read_time > ?', start_date - (i+1).days)
                       .where('read_time <= ?', start_date - i.days)
      Hash[relation.map{ |bsr| [bsr.read_time, bsr.value] }]
    end
  end
end