module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} | PicksTrialAddingUser"
    else
      'PicksTrialAddingUser'
    end
  end
end
