Rails.application.routes.draw do
  get 'scripts/:app/:file', :to => 'scripts#show'
  resources :manifests
  get 'packages/search'
  get 'packages/detail'
  root :to => 'manifests#index'
end
