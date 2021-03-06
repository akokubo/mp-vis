Rails.application.routes.draw do
  # get '/:locale' => 'static_pages#home'
  scope "(:locale)", locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root   'static_pages#home'
    get    '/help',    to: 'static_pages#help'
    get    '/about',   to: 'static_pages#about'
    get    '/contact', to: 'static_pages#contact'
    get    '/signup',  to: 'users#new'
    # 登録に失敗した場合にも/usersにリダイレクトするのでなく、/signupにするために
    post   '/signup',  to: 'users#create'
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
    resources :users
    # ユーザーの有効化を行うリソース
    resources :account_activations, only: [:edit]
    # パスワード再設定を行うリソース(newとcreateがエントリー、editとupdateが再設定)
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :places do
        resources :photos, only: [:create, :destroy]
    end
  end
end
