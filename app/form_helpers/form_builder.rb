class FormBuilder < ActionView::Helpers::FormBuilder
  def datetime_local_select(method)
    #TODO: get rid of this js thing here
    script = "$(function(){ timeSelectInLocalTimezone('##{@object_name}_#{method}') });"
    @template.datetime_select(@object_name, method)
     .concat(@template.javascript_tag script)
  end

  def split_float_fields(method)
    self.label("#{method}_integral", @object.class.human_attribute_name(method))
      .concat(self.number_field("#{method}_integral"))
      .concat(self.label("#{method}_fractional", I18n.t('number.format.separator')))
      .concat(self.number_field("#{method}_fractional"))
  end
end
