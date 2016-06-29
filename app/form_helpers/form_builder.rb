class FormBuilder < ActionView::Helpers::FormBuilder
  def datetime_local_select(method)
    @template.content_tag(:div, class: method, data: { transform: :dateTimeLocalSelects }) do
      @template.datetime_select(@object_name, method)
        .concat(@template.content_tag(:span, class: :timeZone) { @object.send(method).zone })
    end
  end

  def split_float_fields(method)
    @template.content_tag(:div, class: method, data: { transform: :splitFloat }) do
      self.label("#{method}_integral", @object.class.human_attribute_name(method))
        .concat(self.number_field("#{method}_integral", value: integral_part(method)))
        .concat(self.label("#{method}_fractional", I18n.t('number.format.separator')))
        .concat(self.number_field("#{method}_fractional", value: fractional_part(method)))
    end
  end

  private

  def integral_part(method)
    float_parts(method).first.to_i
  end

  def fractional_part(method)
    float_parts(method).last.to_i
  end

  def float_parts(method)
    @object.send(method).to_f.to_s.split('.')
  end
end
