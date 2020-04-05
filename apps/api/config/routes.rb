post "/users", to: "users#create"
post "/users/login", to: "sessions#create"
get "/user", to: "users#show"
put "/user", to: "users#update"
