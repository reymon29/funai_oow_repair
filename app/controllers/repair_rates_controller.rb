class RepairRatesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @repairs = RepairRate.all
  end

  def show
    @repair = RepairRate.find(params[:id])
  end
end
