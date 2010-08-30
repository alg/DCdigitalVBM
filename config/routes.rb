Voter::Application.routes.draw do
  match '/' => 'pages#front', :as => :front
  match '/overview(/:voting_type)' => 'pages#overview', :as => :overview, :constraints => { :voting_type => /(physical|digital)/ }
  match '/check_in' => 'pages#check_in',  :as => :check_in
  match '/confirm'  => 'pages#confirm',   :as => :confirm
  match '/complete' => 'pages#complete',  :as => :complete
  match '/return'   => 'pages#return',    :as => :return
  match '/thanks'   => 'pages#thanks',    :as => :thanks
end
