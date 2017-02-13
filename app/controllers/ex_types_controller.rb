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
    authorize :ex_type, :create?
    @ex_type = ExType.new(ex_type_params)
    if @ex_type.save
      flash[:notice]
      redirect_to ex_types_path
    else
      flash[:errors] = @ex_type.errors.full_messages
      render :new
    end
  end
  
  private
  
  def load_ex_type
    @ex_type = params.has_key?(:id) ? policy(:ex_type).scope.find(params[:id]) : nil
  end

  def load_ex_types
    @ex_types = policy_scope(ExType.all).page(params[:page])
  end

  def ex_type_params
    params.require(:ex_type).permit(policy(@ex_type).permitted_attributes)
  end
end
