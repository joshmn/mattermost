module Mattermost
  class Team < BaseResource

    alias_method :team_id, :id

    # Returns the given team
    #   Team.find("long-team-id").raw
    get :raw, :as => :member, :endpoint => ''

    # Returns stats of a team
    #   Team.find("long-team-id").stats
    get :stats, :as => :member

    # Returns a user by their name
    #   Team.by_name("development")
    get :by_name, :as => :self, :endpoint => 'name/:team_name', :args => :team_name

    # Returns whether or not the team exists
    #   Team.exists("party-planning-committee")
    get :exists, :as => :self, :endpoint => 'name/:team_name/exists', :args => :team_name

    # Returns all the teams on the instance
    #   Team.all
    get :all, :as => :self, :endpoint => ''

    # Creates a team
    #   Team.create(:name => "party-planning-committee", :display_name => "Party Planning Committee", type => 'I')
    post :create, :as => :self, :endpoint => ''

    # Search teams
    #   Team.search("party")
    post :search, :as => :self, :body => :term

    # Gets members of a team
    #   Team.find("long-team-id").members
    get :members, :as => :member

    # Adds a user to a Team
    # Team.find("long-team-id").add_member(:team_id => "long-team-id", :user_id => "long-user-id", :roles => "team_admin")
    post :add_member, :as => :member, :endpoint => 'members'

    # Gets the member status of a user of a particiular team
    # Team.find("long-team-id").member_by_user_id("long-user-id")
    get :member_by_user_id, :as => :member, :endpoint => 'members/:user_id', :args => :user_id

    # Updates a team
    # Team.find("long-team-id").update_attributes(:display_name => "Former Party Planning Committee")
    put :update_attributes, :as => :member, :endpoint => 'patch'

  end
end