Rails.application.routes.draw do
  post 'tokens', to: 'tokens#create'
end
