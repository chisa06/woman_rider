Rails.application.routes.draw do
  
  root to: 'homes#top'
  get "search" => "searches#search"
  
  # 管理者用
  devise_for :admin, skip: [:registrations ], controllers: {
    sessions: "admin/sessions"
  }
    
  # 顧客用
  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  scope module: :user do
    get 'user/:id' => 'users#show', as: 'user'
    resources :tweets, only: [:index, :create, :show, :destroy] do
      resource :like, only: [:create, :destroy]
      resources :comments, only: [:create]
    end
    
    resources :relationships, only: [:create, :destroy], as: 'user_relationships' do
      collection do
  	    get "followings", action: :followings, as: "followings"
        get "followers", action: :followers, as: "followers"
  	  end
  	end
    
    resources :direct_messages, only: [:create]
    resources :rooms, only: [:create, :show]
    	  
  end

end
