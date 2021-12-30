# frozen_string_literal: true

module Rails
  module ConsoleMethods
    def first_user
      User.first
    end

    def first_post
      Post.first
    end

    def first_simple_post
      PostType::Simple.first
    end

    def first_feed
      Feed.first
    end

    def first_comment
      Comment.first
    end

    def first_follow_invitation
      FollowInvitation.first
    end
  end
end
