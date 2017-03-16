module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} | BackofficePicks"
    else
      'BackofficePicks'
    end
  end
end
