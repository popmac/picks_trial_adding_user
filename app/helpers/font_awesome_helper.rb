module FontAwesomeHelper
  def fa_icon(names, options = {})
    classes = [ "fa" ]
    names = names.to_s.split(/\s+/) unless names.kind_of?(Array)
    names.each do |name|
      classes << "fa-#{name}"
    end
    if options[:class]
      classes << options[:class]
    end
    text = options.delete(:text)
    right_icon = options.delete(:right)
    icon = content_tag(:i, nil, options.merge(:class => classes))
    if text.present?
      elements = [ icon, ERB::Util.html_escape(text) ]
      elements.reverse! if right_icon
      safe_join(elements, " ")
    else
      icon
    end
  end
end
