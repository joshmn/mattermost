module Mattermost
  class User < BaseResource

    alias_method :user_id, :id
    post :create, :as => :self, :endpoint => ''
    get :all, :as => :self, :endpoint => ''
    post :by_ids, :as => :self, :endpoint => 'ids'
    post :by_usernames, :as => :self, :endpoint => 'usernames'
    get :autocomplete, :as => :self
    get :raw, :as => :member, :endpoint => ''
    put :update_attributes, :as => :member, :endpoint => 'patch'
    put :roles, :as => :member, :endpoint => 'roles', :args => :roles
    get :image, :as => :member
    get :by_username, :as => :self, :endpoint => 'username/:username'
    get :by_email, :as => :self, :endpoint => 'email/:email'
    get :sessions, :as => :member
    post :revoke, :as => :member, :endpoint => 'sessions/revoke', :args => :session_id
    post :revoke_all, :as => :member, :endpoint => 'sessions/revoke'
    get :audits, :as => :member
    post :verify, :as => :self, :endpoint => 'email/verify'
    post :send_verification_email, :as => :self, :endpoint => 'email/verify/send', :body => :email

    get :teams, :as => :member
    get :team_members, :as => :member, :endpoint => 'teams/members'

    post :search, :as => :self, :endpoint => 'search' # this takes lots of args, should probably look at it
    post :image, :as => :member # i haven't done files yet...this probably won't work
  end
end