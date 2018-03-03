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
end
