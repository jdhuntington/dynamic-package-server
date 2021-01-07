Rails.application.routes.draw do
  get 'scripts/:app/:file', :to => 'scripts#show'
  resources :manifests
  get 'packages/search'
  root :to => 'manifests#index'
end
