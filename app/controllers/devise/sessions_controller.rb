class Devise::SessionsController < DeviseTokenAuth::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def render_create_success
    render json: {
      user: resource_data(resource_json: @resource.token_validation_response),
      roles: @resource.roles
    }
  end
end
