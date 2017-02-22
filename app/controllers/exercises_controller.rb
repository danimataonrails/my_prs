class ExercisesController < ApplicationController
  before_action :load_exercise, except: [:index, :new, :create]
  
  def index
    authorize :exercise, :index?
    load_exercises
    respond_to do |format|
      format.html
      format.xml { render :xml => @exercises.to_xml }
      format.json { render :json => @exercises.to_json }
    end
  end
  
  def new
    authorize :exercise, :new?
    @exercise = Exercise.new
  end
  
  def create
    @exercise = Exercise.new(exercise_params)
    authorize @exercise, :create?
    if @exercise.save
      flash[:notice] = ''
      redirect_to exercises_path
    else
      flash[:errors] = @exercise.errors.full_messages
      render :new
    end
  end
  
  def show
    authorize @exercise, :show?
  end
  
  def edit
    authorize @exercise, :edit?
  end
  
  def update
    authorize @exercise, :update?
    if @exercise.update_attributes(exercise_params)
      flash[:notice] = ''
      redirect_to exercises_path
    else
      flash[:errors] = @exercise.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    authorize @exercise, :destroy?
    if @exercise.destroy
      flash[:notice] = ''
    else
      flash[:errors] = ''
    end
    redirect_to exercises_path
  end
  
  private
  
  def load_exercise
    @exercise = params.has_key?(:id) ? policy_scope(Exercise).find(params[:id]) : nil
  end

  def load_exercises
    @exercises = policy_scope(Exercise.all).page(params[:page])
  end

  def exercise_params
    params.require(:exercise).permit(policy(:exercise).permitted_attributes)
  end
end
