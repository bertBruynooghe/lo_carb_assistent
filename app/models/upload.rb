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
