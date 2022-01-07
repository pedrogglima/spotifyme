# frozen_string_literal: true

module Rails
  module ConsoleMethods
    def first_user
      User.first
    end
    alias user first_user

    def first_post
      Post.first
    end
    alias post first_post

    def first_posts_user
      Posts::User.first
    end
    alias posts_user_post first_posts_user

    def first_feed
      Feed.first
    end
    alias feed first_feed

    def first_comment
      Comment.first
    end
    alias comment first_comment

    def first_follow_invitation
      FollowInvitation.first
    end
    alias follow_invitation first_follow_invitation

    def posts_user_posts(user = nil)
      user ||= first_user
      user.posts_user_posts
    end

    def followers(user = nil)
      user ||= first_user
      FollowInvitation.where(following: user, status: :accepted)
    end

    def followings(user = nil)
      user ||= first_user
      FollowInvitation.where(follower: user, status: :accepted)
    end

    def update_invitation_to_pending(user = nil)
      user ||= first_user
      FollowInvitation.update(status: :pending).where(following: user)
    end

    def update_invitation_to_accepted(user = nil)
      user ||= first_user
      FollowInvitation.update(status: :accepted).where(following: user)
    end

    def list_posts_with_likes_from_user(user = nil)
      user ||= first_user
      Post.by_user(user.id).each do |post|
        puts "Post: #{post.id} | User: #{post.user_nickname} \
        | Simples: #{post.posts_user_id} | Simples: #{post.posts_user_counter_likeable} \
        | Likes: #{post.like_id} | Likes: #{post.like_user_id}"
      end
    end
  end
end
