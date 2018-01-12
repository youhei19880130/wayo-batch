class TopController < ApplicationController
  def index
  end

  def update_stock
    UpdateStockJob.perform_now(params[:file])
    redirect_to root_path, notice: '処理が終了しました'
  end

  def update_stock
    UpdateTrackingJob.perform_now(params[:file])
    redirect_to root_path, notice: '処理が終了しました'
  end
end
