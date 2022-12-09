
class HomeController < ApplicationController

  include CodeProtectedController

  def index
    @report = SragReportHelper::SragReporter.new
  end

end
