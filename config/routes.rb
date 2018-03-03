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
      end
    end
end
