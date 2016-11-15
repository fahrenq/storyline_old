Rails.application.routes.draw do
  scope module: 'web' do
    root to: 'static_pages#welcome'
    # Devise routing start
    devise_for :users, path: '', controllers: {
      sessions: 'custom_sessions',
      registrations: 'custom_registrations',
      confirmations: 'custom_confirmations'
    },
    path_names: {
      sign_up: 'registration',
      sign_out: 'logout',
      sign_in: 'login'
    }
    # Devise routing end

    resources :stories do
      scope module: 'moments' do
        resources :native_moments, shallow: true
        resources :embedded_moments, shallow: true
      end
    end
    resources :notifications, only: [:index]
    post '/story/:id/subscribe', to: 'stories#subscribe', as: :subscribe_to_story
    delete '/story/:id/unsubscribe', to: 'stories#unsubscribe', as: :unsubscribe_from_story
  end
end
