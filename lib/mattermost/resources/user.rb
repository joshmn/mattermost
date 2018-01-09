module Mattermost
  class User < BaseResource

    alias_method :user_id, :id

    # Creates a user
    #   User.create(:email => "ryan@dundermifflin.com", :username => "ryanhoward", :password => "ilovekelly")
    post :create, :as => :self, :endpoint => ''

    # Gets all users
    #   User.all
    get :all, :as => :self, :endpoint => ''

    # Gets users by their user IDs
    #   User.by_ids("long-user-id-1", "long-user-id-2")
    post :by_ids, :as => :self, :endpoint => 'ids'

    # Gets users by their usernames
    #   User.by_usernames("long-username-1", "long-username-2")
    post :by_usernames, :as => :self, :endpoint => 'usernames'

    # Opens an autocomplete endpoint
    # Requires :name; optional params are :team_id, :channel_id
    # :name can be a username, nickname, first name, or last name
    #   User.autocomplete(:name => "something")
    get :autocomplete, :as => :self

    # Returns the given user
    #   User.find("long-user-id").raw
    get :raw, :as => :member, :endpoint => ''

    # Updates a user
    #   User.find("long-user-id").update_attributes(:email => "ceo@dundermifflin.com")
    put :update_attributes, :as => :member, :endpoint => 'patch'

    # Updates the user's roles
    #   User.find("long-user-id").roles("team_admin")
    put :roles, :as => :member, :endpoint => 'roles', :args => :roles

    # Gets the member's avatar/display pic thing
    #   User.find("long-user-id").image
    get :image, :as => :member

    # Gets users by their username
    #   User.by_username("ryan")
    get :by_username, :as => :self, :endpoint => 'username/:username'

    # Gets users with a matching email
    get :by_email, :as => :self, :endpoint => 'email/:email'

    # Gets current user sessions
    get :sessions, :as => :member

    # Revokes a given session
    # User.find("long-user-id").revoke("session-id")
    post :revoke_session, :as => :member, :endpoint => 'sessions/revoke', :args => :session_id

    # Revokes all sessionds
    post :revoke_all_sessions, :as => :member, :endpoint => 'sessions/revoke'

    # Does an audit on the user
    get :audits, :as => :member

    # Verify the email used by a user to sign-up with
    # User.verify("token")
    post :verify_email, :as => :self, :endpoint => 'email/verify'

    # Resend verification email
    # User.send_verification_email("ryan@dundermifflin.com")
    post :send_verification_email, :as => :self, :endpoint => 'email/verify/send', :body => :email

    # Get the teams a user is a member of
    # User.find("long-user-id").teams
    get :teams, :as => :member

    # ...
    get :team_members, :as => :member, :endpoint => 'teams/members'



    # These probably don't work
    post :search, :as => :self, :endpoint => 'search' # this takes lots of args, should probably look at it
    post :image, :as => :member # i haven't done files yet...this probably won't work
  end
end