class CatRentalRequestsController < ApplicationController
  before_action :cat_owner_check, only: [:approve, :deny]

  def new
    @cats = Cat.all
    @request = CatRentalRequest.new

    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_request_params)
    @request.user_id = current_user.id
    if @request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def approve
    CatRentalRequest.find(params[:id]).approve!
    redirect_to cats_url
  end

  def deny
    CatRentalRequest.find(params[:id]).deny!
    redirect_to cats_url
  end

  private

  def cat_owner_check
    @cat = CatRentalRequest.find(params[:id]).cat
    if current_user.nil?
      redirect_to cat_url(@cat)
    elsif current_user.id != @cat.user_id
      redirect_to cat_url(@cat)
    end
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date)
  end
end
