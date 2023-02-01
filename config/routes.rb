Rails.application.routes.draw do
  get "/", to: "user#index"
  root to: "user#index"
  post "/register", to: "user#register"
  post "/login", to: "user#login"
  get "/wall", to: "message#index"
  get "/logout", to: "user#logout"
  post "/message_post", to: "message#message_post"
  post "/comment_post", to: "comment#comment_post"
  delete "/message_delete", to: "message#message_delete"
  delete "/comment_delete", to: "comment#comment_delete"

  get 'message/index'
  get 'user/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
