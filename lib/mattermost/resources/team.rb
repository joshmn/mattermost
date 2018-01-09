module Mattermost
  class Team < BaseResource

    alias_method :team_id, :id

    get :raw, :as => :member, :endpoint => ''
    get :stats, :as => :member
    get :by_name, :as => :self, :endpoint => 'name/:team_name', :args => :team_name
    get :exists, :as => :self, :endpoint => 'name/:team_name/exists', :args => :team_name
    get :all, :as => :self, :endpoint => ''
    post :create, :as => :self, :endpoint => ''
    post :search, :as => :self, :body => :term
    get :members, :as => :member
    post :add_member, :as => :member, :endpoint => 'members'
    get :member_by_user_id, :as => :member, :endpoint => 'members/:user_id', :args => :user_id
    put :update_attributes, :as => :member, :endpoint => 'patch'


  end
end