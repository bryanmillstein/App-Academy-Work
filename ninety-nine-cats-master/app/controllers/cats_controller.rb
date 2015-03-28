class CatsController < ApplicationController
  before_action :cat_owner_check, only: [:edit, :update]

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @sorted_requests = @cat.rental_requests.order(:start_date)
    # @sorted_requests = requests.sort_by {|request| request[:start_date]}
    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def edit
    render :edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  private

  def cat_owner_check
    @cat = Cat.find(params[:id])
    if current_user.nil?
      redirect_to cat_url(@cat)
    elsif current_user.id != @cat.user_id
      redirect_to cat_url(@cat)
    end
  end

  def cat_params
    params.require(:cat)
      .permit(:birth_date, :name, :color, :sex, :description)
  end

end
