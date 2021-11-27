class FormBuilder < ActionView::Helpers::FormBuilder
  def split_float_fields(method, options = {})
    @template.content_tag(:div, class: method, data: { controller: 'split-float' }) do
      self.label("#{method}_integral", @object.class.human_attribute_name(method))
        .concat(self.number_field("#{method}_integral", placeholder: '0', data: { 'split-float-target': :integral }))
        .concat(self.label("#{method}_fractional", I18n.t('number.format.separator')))
        .concat(self.number_field("#{method}_fractional", placeholder: '00', data: { 'split-float-target': :fractional }))
    end
  end
end
