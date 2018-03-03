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

  def check_if_submitted
    submitted = false
    if UsersField.where('user_id = ? AND date > ? AND date < ?',current_user.id, DateTime.now.beginning_of_day,DateTime.now.beginning_of_day+1.day).size > 0
      submitted = true
    end
    render json:{submitted: submitted}
  end

  def fields_report
    result = []
    today_answers = UsersField.where('date > ? AND date < ?', DateTime.now.beginning_of_day,DateTime.now.beginning_of_day+1.day)
    Field.all.each do |field|
      result << {
        desc:field.desc,
        yes:today_answers.where(field_id:field.id,state:1).count,
        no:today_answers.where(field_id:field.id,state:nil).count,
      }
    end

    render json:{report: result}
  end

  private

  def field_params
    params.fetch(:field, {}).permit(:user_id, :state)
  end
end
