class FormBuilder < ActionView::Helpers::FormBuilder
  def datetime_local_select(method)
    @template.content_tag(:div, class: method, data: { transform: :dateTimeLocalSelect }) do
      @template.datetime_select(@object_name, method)
        .concat(@template.content_tag(:span, class: :timeZone) { (@object.send(method)||DateTime.now).zone })
    end
  end

  def split_float_fields(method)
    @template.content_tag(:div, class: method, data: { transform: :splitFloat }) do
      self.label("#{method}_integral", @object.class.human_attribute_name(method))
        .concat(self.number_field("#{method}_integral", value: integral_part(method), placeholder: '0'))
        .concat(self.label("#{method}_fractional", I18n.t('number.format.separator')))
        .concat(self.number_field("#{method}_fractional", value: fractional_part(method), placeholder: '00'))
    end
  end

  private

  def integral_part(method)
    float_parts(method).first.to_i.tap{ |i| return nil if  i == 0 }
  end

  def fractional_part(method)
    float_parts(method).last.to_i.tap{ |i| return nil if  i == 0 }
  end

  def float_parts(method)
    @object.send(method).to_f.to_s.split('.')
  end
end
