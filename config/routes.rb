OW::Application.routes.draw do
  resources :message_boxes do
    resources:comments
  end

  resources :invoices
  match "/invoices/:invoice_id/payments/new"=>'invoices#new_payment' ,:as=>:new_payments
   match "/invoices/:invoice_id/payments/create"=>'invoices#create_payment' ,:as=>:payments
  match "/payments/:payment_id"=>'invoices#destroy_payment',:as=>:payments_destroy
  resources :documents

  get "search/new_search"
  get "search/search_options",:as =>:search_options
  get "search/search_result"
 match "search/:model_id/test"=>"search#test"

  resources :supports

  resources :comments
 # match "/project/:project_id/comments"=>'comments#project_comments_index' ,:as=>:project_comments_index
  #match "/project/:project_id/comments/new"=>'comments#new' ,:as=>:new_project_comment

  resources :projects do
    resources :invoices
    
  end

  #resources :clients

  root :to => 'home_page#home'

  get "home_page/home"
   get "home_page/test"
  #get "user_profiles/edit"

  #get "user_profiles/show"
  #get "user_profiles/new"

  resources :clients do
    resources :projects
  end
  match "/comments/:id/read"=>"comments#read_comment",:as=>:read_comment
  match "/comments/:id/archive"=>"comments#archive_comment",:as=>:archive_comment
  match "/comments/:id/trash"=>"comments#trash_comment",:as=>:trash_comment
  match "/projects/:id/activate_project"=>"projects#activate_project",:as=>:activate_project
  match "/users/:id/activate_user"=>"users#activate_user",:as=>:activate_user
  match "/projects/:id/activate_project"=>"projects#activate_project",:as=>:activate_project
  match "/clients/:id/change_state"=>"clients#change_state",:as=>:client_change_state

  match "/current_user_projects"=>'projects#current_user_projects',:as =>:current_user_projects
  match "/current_user_clients"=>'clients#current_user_clients',:as =>:current_user_clients
  match "/user_clients/:user_id"=>'clients#user_clients',:as =>:user_clients

  get "sessions/new"

  match "files/upload", :to =>'files#upload' ,:as =>'upload_files'
  match "files/post_upload", :to =>'files#post_upload' ,:as =>'post_upload'
  get "files/index"

  get "users/show"


  match 'user_upload', :to => 'users#upload_a_file'
  match 'project_upload', :to => 'projects#upload_a_file'


  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/redirect', :to =>'application#redirect_to_last_visited'
  match '/projects/:id/fiche_de_rendez_vous',:to=>'projects#create_rendez_vous_fiche' ,:as=>:fiche_de_rendez_vous
  match '/projects/:id/fiche_de_rendez_vous_mail',:to=>'projects#send_fiche_de_rendez_vous_mail' ,:as=>:fiche_de_rendez_vous_mail
  match '/projects/:id/SAV_form' ,:to=>'projects#send_SAV_form_mail',:as=>:send_SAV_form_mail
  match '/project/:id/follow',:to=>'projects#follow_project',:as=>:follow_project
  match '/project/:id/assign',:to=>'projects#assign_project',:as=>:assign_project
  resources :user_profiles
  resources :users do
    resource :user_profiles # a verifier

  end

  post "files/post_upload"
  match 'files/download' =>'files#download'

  resources :files
  resources :sessions, :only => [:new, :create, :destroy]

  match '/file_browser' => 'file_browser#list', :as => :file_browser
  match '/user_files' => 'file_browser#user_files', :as => :user_files
   match '/projects/:project_id/project_files' => 'file_browser#project_files', :as => :project_files
  match '/projects/:project_id/file_browser/file/create'  => 'file_browser#create_file',  :as => :create_project_file_file_browser
  match '/file_browser/delete' => 'file_browser#delete', :as => :delete_file_file_browser
  match '/file_browser/dir/create'  => 'file_browser#create_dir',  :as => :create_dir_file_browser
  match '/file_browser/file/create'  => 'file_browser#create_file',  :as => :create_file_file_browser
  get "welcome/index"
  resources :supports, :only => [:new, :create]
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
