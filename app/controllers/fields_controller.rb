class FieldsController < ApplicationController
  def index
    if !current_user || current_user.roles.where(name:"admin").exists?
      @fields = Field.all.order("id ASC, for ASC")
    else
      user_roles = current_user.roles.pluck(:name)
      @fields = Field.where(for:user_roles+["all"]).order("id ASC, for ASC")
    end
    render json: @fields
  end

  def fields_per_role
    user_roles = current_user.roles.pluck(:name)
    @fields = Field.where(for:user_roles)
    render json: @fields
    
  end

  def new
  end

  def create
    puts "params------------"
    pp params
    field = Field.create(field_params)
    render json: field
  end

  # PATCH/PUT /fields/1
  def update
    @field = Field.find(params[:id])
    if @field.update(field_params)
      render json: @field
    else
      render json: @field.errors, status: :unprocessable_entity
    end
  end
  def edit
  end

  def destroy
    field = Field.find(params[:id])
    if field.destroy
      render json: field
    end
  end


  def show
    field = Field.find(params[:id])
    render json: field
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
        no:today_answers.where(field_id:field.id,state:[nil,0]).count,
        field_id: field.id
      }
    end

    render json:{report: result}
  end

  def report_per_field
    result = []
    yes_answers = UsersField
      .where(field_id:params[:id])
      .where('date > ? AND date < ? AND (state=0 OR state is null)', DateTime.now.beginning_of_day,DateTime.now.beginning_of_day+1.day).joins(:user).map{|a|a.user.email}
    # yes_answers.each do |answer|
    #   result << {
    #     email: User.find(answer.user_id).email
    #   }
    # end
    pp yes_answers
    render json:{report: yes_answers}
    
  end

  private

  def field_params
    params.fetch(:field, {}).permit(:user_id, :state, :desc, :for)
  end
end
