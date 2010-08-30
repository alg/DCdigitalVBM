class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :voting_type, :physical?, :digital?

  def voting_type=(type)
    session[:voting_type] = type.to_s if %w( digital physical ).include?(type.to_s)
  end
  
  def voting_type
    session[:voting_type] || "physical"
  end

  def physical?
    voting_type == "physical"
  end
  
  def digital?
    !physical?
  end
end
