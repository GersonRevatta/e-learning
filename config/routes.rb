Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: %i[json raw] } do
    namespace :v1 do
      resources :courses, only: %i[index show create update destroy] do
        resources :lessons, only: %i[index show create update destroy] do
          resources :questions, only: %i[index show create update destroy]
        end
      end

      resources :choice_lessons, only: [] do
        collection do
          post :take
        end
      end
    end
  end
end
