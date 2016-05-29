Rails.application.routes.draw do
  root to:  'stocks#show'
  post '/stocks/add_or_get_stock_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
end
