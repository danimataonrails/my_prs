class ExTypesController < ApplicationController
  before_action :load_ex_type, except: [:index, :new, :create]
  
  def index
    authorize :ex_type, :index?
    load_ex_types
    respond_to do |format|
      format.html
      format.xml { render :xml => @ex_types.to_xml }
      format.json { render :json => @ex_types.to_json }
    end
  end
  
  def new
    authorize :ex_type, :new?
    @ex_type = ExType.new
  end
  
  def create
    @ex_type = ExType.new(ex_type_params)
    authorize @ex_type, :create?
    if @ex_type.save
      flash[:notice] = ''
      redirect_to ex_types_path
    else
      flash[:errors] = @ex_type.errors.full_messages
      render :new
    end
  end
  
  def destroy
    authorize @ex_type, :show?
  end
  
  def destroy
    authorize @ex_type, :destroy?
    if @ex_type.destroy
      flash[:notice] = ''
    else
      flash[:errors] = ''
    end
    redirect_to ex_types_path
  end
  
  private
  
  def load_ex_type
    @ex_type = params.has_key?(:id) ? policy_scope(ExType).find(params[:id]) : nil
  end

  def load_ex_types
    @ex_types = policy_scope(ExType.all).page(params[:page])
  end

  def ex_type_params
    params.require(:ex_type).permit(policy(:ex_type).permitted_attributes)
  end
end
