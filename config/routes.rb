Karmaville::Application.routes.draw do
  resources :users, :only => [:index]

  get '/' => 'users#show'
  get '/:id' => 'users#show'
end
