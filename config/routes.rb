Rails.application.routes.draw do
  resources :students
  resources :sessions do
    member do
      post 'add_student'
      delete 'remove_student'
    end
  end
  resources :attendances
  resources :search
  root 'landing_page#index'
  resources :landing_page
  get '/import_students/import' => 'import_students#import_page', :as => :csv_import_page
  post '/import_students/imported' => 'import_students#import', :as => :csv_imported
end
