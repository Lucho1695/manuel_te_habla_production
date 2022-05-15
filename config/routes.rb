Rails.application.routes.draw do
  resources :responses, except: [:new, :show] do
    collection do
      get 'new/:questionnaire_id', to: "responses#new", as: 'new'
      get 'show/:questionnaire_id', to: "responses#show", as: 'show'
    end
  end
  resources :questionnaires
  resources :projects
  resources :check_lists
  resources :progresses
  resources :goals
  resources :levels
  resources :level_assignments
  resources :people

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :categories do
    member do
      get 'show_small_category_image'
      get 'show_category_themes'
    end
  end
  resources :contacts
  resources :upload_files, only: :index do
    member do
      get 'show_small_upload_file_thumbnail'
      get 'show_upload_file_thumbnail'
    end
  end
  resources :games do
    member do
      get "puzzle", to: "games#puzzle"
      get "puzzle_category"
      get "memory", to: "games#memory"
      get "memory_log", to: "games#memory_log"
      get "puzzle_log", to: "games#puzzle_log"
    end
  end

  resources :charts do
    collection do
      get 'show_goals/:goal_id', to: "charts#show_goals", as: "show_goals"
      get 'goals'
      get 'timelines'
      get 'childs'
      get 'level_assignments'
      get 'categories'
      get 'user_logs/:user_log_id', to: "charts#user_logs"
    end
  end

  resources :users do
    collection do
      get 'show_small_image'
    end
  end
  resources :say_ideas do
    collection do
      get 'verbs', to: 'say_ideas#verbs'
      get 'complement', to: 'say_ideas#complement'
    end
  end
  resources :themes, only: :index do
    member do
      get 'show_category_themes'
      get 'show_small_category_image'
    end
  end
  resources :video_files, only: :index do
    member do
      get 'show_category_video_files'
    end
  end
  resources :videos do
    member do
      get 'show_video_file'
      get 'show_small_video_file_thumbnail'
    end
  end
  root "categories#index"
end
