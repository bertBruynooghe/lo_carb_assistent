class FormBuilderWithLocalTimeSupport < ActionView::Helpers::FormBuilder
  def datetime_local_select(method)
    @template.datetime_select(@object_name, method)
     .concat(@template.javascript_tag "$(function(){ timeSelectInLocalTimezone('##{@object_name}_#{method}') });")
  end
end
