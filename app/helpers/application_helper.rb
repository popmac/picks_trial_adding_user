module ApplicationHelper
  include HtmlBuilder

  def document_title
    if @title.present?
      "#{@title} | PicksTrialAddingUser"
    else
      'PicksTrialAddingUser'
    end
  end
end
