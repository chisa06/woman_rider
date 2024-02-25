Rails.application.routes.draw do
  
  root to: 'homes#top'
  
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
    end
    
    resource :relationships, only: [:create, :destroy]
  	  get "followings" => "relationships#followings", as: "followings"
  	  get "followers" => "relationships#followers", as: "followers"
  	  get "search" => "searches#search"
    
  end

end
