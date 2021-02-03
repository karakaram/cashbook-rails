Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # Replace ActiveAdmin.routes(self) with below line. For details, see https://github.com/hzamani/acts_as_relation/issues/71
  ActiveAdmin.routes(self) rescue ActiveAdmin::DatabaseHitDuringLoad
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
