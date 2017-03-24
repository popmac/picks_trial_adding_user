class Admin::DashboardController < Admin::Base
  before_action :authorize

  def index
  end
end
