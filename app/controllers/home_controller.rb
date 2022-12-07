
class HomeController < ApplicationController

  def index
    @report = SragReportHelper::SragReporter.new
  end

end
