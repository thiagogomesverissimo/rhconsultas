Rails.application.routes.draw do

  resources :pessoas
  resources :setors

  get 'titulos' => 'pessoas#titulos', as: 'titulos'
  get 'titulosfunc' => 'pessoas#titulosfunc', as: 'titulosfunc'
  get 'profissional' => 'pessoas#profissional', as: 'profissional'
  get 'historico' => 'pessoas#historico', as: 'historico'
  get 'colegiados' => 'pessoas#colegiados', as: 'colegiados'
  get 'suplencias' => 'pessoas#suplencias', as: 'suplencias'

  get 'chefias' => 'pessoas#chefias', as: 'chefias'

  get 'escolhe_relatorio' => 'pessoas#escolhe_relatorio'
  get 'gera_relatorio' => 'pessoas#gera_relatorio'
  get 'gera_relatorioex' => 'pessoas#gera_relatorioex'

  # home
  get 'home/index'

  root 'home#index'

  #get 'validacao' => 'pessoas#validacao', as: 'validacao'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:-
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
