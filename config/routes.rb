Rails.application.routes.draw do
  get '/' => "top#index"
  get '/tag/:id' => "top#tag"
  get '/category/:id' => "top#category"
  get '/:id' => "top#show"
  get '/tag' => "top#tag_index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
