Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'users', controllers: {
      registrations: 'devise/registrations',
      sessions: 'devise/sessions',
      passwords: 'devise/passwords',
      confirmations: 'devise/confirmations'
    }
    resources :fields do
      collection do
        post :submit_fields
        get :check_if_submitted
        get :fields_report
        get :fields_per_role
      end
      member do
        get :report_per_field
      end
    end

    resources :roles
end
