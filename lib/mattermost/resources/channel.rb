module Mattermost
  class Channel < BaseResource

    alias_method :channel_id, :id

    # Creates a channel
    #   Channel.create(:team_id => "long-team-id", :name => "michaels-party", :display_name => "Michael's Party", :type => 'O')
    post :create, :as => :self

  end
end