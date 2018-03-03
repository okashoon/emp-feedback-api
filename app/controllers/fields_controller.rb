class FieldsController < ApplicationController
  def index
    @fields = Field.all
    pp @fields
    pp current_user
    render json: @fields
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end


  def show
  end

  def submit_fields
   
    fields = params[:fields]

    fields.each do |field|
      UsersField.create(user_id:params[:user_id],field_id:field['id'],state:field['state'],date:DateTime.now)
    end

  end

  private

  def field_params
    params.fetch(:field, {}).permit(:user_id, :state)
  end
end
