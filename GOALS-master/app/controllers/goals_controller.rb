class GoalsController < ApplicationController
  before_action :require_logged_in
  before_action :cannot_edit_others_goals, only: [:edit, :update]

  def index
    @goals = Goal.all
                 .where("privacy = 'Public' OR user_id = ?", current_user.id)
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :edit
    end

  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  private

    def goal_params
      params.require(:goal).permit(:title,
                                   :notes,
                                   :completion_station,
                                   :privacy)
    end

    def cannot_edit_others_goals
      @goal = Goal.find(params[:id])
      redirect_to user_url(@goal.user) unless @goal.user == current_user
    end

end
