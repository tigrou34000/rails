Rails.application.routes.draw do
	scope "(:locale)", locale: /en|fr/ do
		post 'authenticate', to: 'authentication#authenticate'

		resources :users

		resources :towns, only: [:index, :show, :create]

		resources :aerodromes, only: [:index, :create]

		resources :apidocs, only: [:index]

	end
end
