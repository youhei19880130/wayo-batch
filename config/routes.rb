Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root 'top#index' 

 post 'update_stock' => 'top#update_stock'
 post 'update_tracking' => 'top#update_tracking'
end
