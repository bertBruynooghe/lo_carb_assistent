class Upload
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  #attribute :content, String

  def persisted?
    false
  end

  def content=(incoming_file)
    @content = incoming_file
  end

  def save(*args)
    3.times.each { @content.tempfile.readline }
    while !@content.eof?
      save_line(@content.tempfile.readline)
    end
  end

  private

  def save_line(line)
    tokens = line.split("\t")
    time = DateTime.strptime("#{tokens.second} CET", '%Y-%m-%d %H:%M %Z')
    extract_glucose(tokens, time)
    extract_insulin(tokens, time)
  end

  def extract_insulin(tokens, time)
    fast = tokens[6]
    if fast.present?
      fast = fast.gsub(',', '.').to_f
      if InsulinDose.where(application_time: time, dose: fast, insulin_id: 1).empty?
        InsulinDose.create(application_time: time, dose: fast, insulin_id: 1)
      end
    end
    byebug
    slow = tokens[10]
    if slow.present?
      slow = slow.gsub(',', '.').to_f
      if InsulinDose.where(application_time: time, dose: slow, insulin_id: 2).empty?
        InsulinDose.create(application_time: time, dose: slow, insulin_id: 2)
      end
    end
  end

  def extract_glucose(tokens, time)
    glucose = tokens.fourth
    glucose = tokens.fifth unless glucose.present?
    if glucose.present?
      existing = BloodSugarReading.where(read_time: time, value: glucose.to_i).first
      if  existing
        existing.update(manual: false) if existing.manual && tokens.third == '0'
      else
        BloodSugarReading.create(read_time: time, value: glucose.to_i, manual: tokens.third == '1')
      end
    end
  end
end
