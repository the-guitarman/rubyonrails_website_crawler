Rails.application.routes.draw do
  resources :urls
  resources :url_patterns
  resources :pages
  resources :user_agents
  resources :news
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  #get 'welcome/:action', to: redirect('/wiki/%{action}')
  get 'welcome/:action', to: redirect('/')

  root 'welcome#index'
end
