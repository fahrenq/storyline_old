Rails.application.routes.draw do
  scope module: 'web' do
    # Devise routing start
    devise_for :users, path: '', controllers: {
      sessions: 'custom_sessions',
      registrations: 'custom_registrations',
      confirmations: 'custom_confirmations',
      passwords: 'devise/passwords'
    },
    path_names: {
      sign_up: 'registration',
      sign_out: 'logout',
      sign_in: 'login'
    }
    authenticated :user do
      root to: 'users#home', as: :authenticated_root
    end
    # Devise routing end
    root to: 'static_pages#welcome'
    patch '/change_avatar', to: 'users#change_avatar', as: :change_avatar
    delete '/destroy_avatar', to: 'users#destroy_avatar', as: :destroy_avatar

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
