class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def error_messages_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: 'form-control-feedback') do
          m << message
        end
      end
    end
  end

end
