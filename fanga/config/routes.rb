Rails.application.routes.draw do
	scope "(:locale)", locale: /en|fr/ do
		post 'authenticate', to: 'authentication#authenticate'

    
		resources :users
		
		put 'users/:id/activateaccount/:token_account', to: "users#activateaccount"

    resources :trips
     
		resources :towns, only: [:index, :show, :create]

		resources :aerodromes, only: [:index, :create]

		resources :apidocs, only: [:index]

	end
end
