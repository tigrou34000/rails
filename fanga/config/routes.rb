Rails.application.routes.draw do
	scope "(:locale)", locale: /en|fr/ do
		post 'authenticate', to: 'authentication#authenticate'

		resources :users
	end
end
