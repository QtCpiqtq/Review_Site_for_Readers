class Admin::FeelingAfterReadingsController < ApplicationController
  def index
    @feeling_after_reading =  FeelingAfterReading.new
    @feeling_after_readings = FeelingAfterReading.all
  end
  
  def create
    feeling_after_reading = FeelingAfterReading.new(feeling_after_reading_params)
    if feeling_after_reading.save
      flash[:notice] = "読後感の登録に成功しました。"
      redirect_to admin_feeling_after_readings_path
    else
      flash.now[:alert] = "読後感の登録に失敗しました。"
      @feeling_after_reading =  FeelingAfterReading.new
      @feeling_after_readings = FeelingAfterReading.all
      render :index
    end
  end
  
  def destroy
    feeling_after_reading = FeelingAfterReading.find(params[:id])
    if feeling_after_reading.destroy
      flash[:notice] = "読後感の削除に成功しました。"
      redirect_to admin_feeling_after_readings_path
    else
      flash.now[:alert] = "読後感の削除に失敗しました。"
      @feeling_after_reading =  FeellingAfterReading.new
      @feeling_after_readings = FeellingAfterReading.all
      render :index
    end
  end
  
  private
  
  def feeling_after_reading_params
    params.require(:feeling_after_reading).permit(:name)
  end
end
