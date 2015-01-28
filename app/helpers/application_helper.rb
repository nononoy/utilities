module ApplicationHelper

  def class_active?(controller, action)
    if params[:controller] == controller && action.include?(params[:action])
      'active'
    else
      ''
    end
  end

end
