class FormBuilder < ActionView::Helpers::FormBuilder
  def datetime_local_select(method)
    @template.content_tag(:div, class: method, data: { transform: %w(dateTimeLocalSelect steppable).join(' ') }) do
      datetime_select(method, end_year: Date.tomorrow.year, with_css_classes: true)
        .concat(@template.content_tag(:span, class: :timeZone) { (@object.send(method)||DateTime.now).zone })
    end
  end

  def split_float_fields(method, options = {})
    @template.content_tag(:div, class: method, data: { transform: :splitFloat }) do
      self.label("#{method}_integral", @object.class.human_attribute_name(method))
        .concat(self.number_field("#{method}_integral", placeholder: '0'))
        .concat(self.label("#{method}_fractional", I18n.t('number.format.separator')))
        .concat(self.number_field("#{method}_fractional", placeholder: '00'))
    end
  end
end
