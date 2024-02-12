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
    get 'users/mypage' => 'users#show'
    resources :tweets, only: [:new, :show]
    
  end

end
