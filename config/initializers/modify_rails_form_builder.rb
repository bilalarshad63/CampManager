class ActionView::Helpers::FormBuilder
  def error_message_for(field_name)
    if object.errors[field_name].present?
      model_name              = object.class.name.downcase
      id_of_element           = "error_#{model_name}_#{field_name}"
      target_elem_id          = "#{model_name}_#{field_name}"
      class_name              = 'text-danger font-weight-light'
      error_declaration_class = 'has-signup-error'

      "<div id=\"#{id_of_element}\" for=\"#{target_elem_id}\" class=\"#{class_name}\">"\
      "#{object.errors[field_name].join('<br>')}"\
      '</div>'\
      '<!-- Later JavaScript to add class to the parent element -->'\
      '<script>'\
          'document.onreadystatechange = function(){'\
            "$('##{id_of_element}').parent()"\
            ".addClass('#{error_declaration_class}');"\
          '}'\
      '</script>'.html_safe
    end
  rescue StandardError
    nil
  end
end
