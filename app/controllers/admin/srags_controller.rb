class Admin::SragsController < Admin::AdminController

  include AuthenticatedController

  def index
    @srags = Srag.page(params[:page])
  end

end
