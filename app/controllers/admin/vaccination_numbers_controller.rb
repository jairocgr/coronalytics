class Admin::VaccinationNumbersController < Admin::AdminController

  include AuthenticatedController

  def index
    @numbers = VaccinationNumber.page(params[:page])
  end

end
