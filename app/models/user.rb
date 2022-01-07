# frozen_string_literal: true

class User < ApplicationRecord
  has_many :feeds, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :posts_users, through: :posts, source: :postable, source_type: 'Posts::User'
  has_many :comments, dependent: :destroy
  has_many :likes, class_name: 'Like', dependent: :destroy
  has_many :follow_invitations, foreign_key: 'follower_id', class_name: 'FollowInvitation'
  has_many :following_invitations, foreign_key: 'following_id', class_name: 'FollowInvitation'

  scope :followers, lambda {
                      joins(:follow_invitations)
                        .where(follow_invitations: { status: FollowInvitation.statuses[:accepted] })
                    }

  scope :followings, lambda {
                       joins(:following_invitations)
                         .where(follow_invitations: { status: FollowInvitation.statuses[:accepted] })
                     }

  scope :followers_pending, lambda {
                              joins(:follow_invitations)
                                .where(follow_invitations: { status: FollowInvitation.statuses[:pending] })
                            }

  scope :followings_pending, lambda {
                               joins(:following_invitations)
                                 .where(follow_invitations: { status: FollowInvitation.statuses[:pending] })
                             }

  scope :followers_rejected, lambda {
                               joins(:follow_invitations)
                                 .where(follow_invitations: { status: FollowInvitation.statuses[:rejected] })
                             }

  scope :followings_rejected, lambda {
                                joins(:following_invitations)
                                  .where(follow_invitations: { status: FollowInvitation.statuses[:rejected] })
                              }

  def feeds_visiable
    Feed.where(user_id: id, visiable: true)
  end

  def followers
    FollowInvitation.where(follower_id: id, status: :accepted)
  end

  def followings
    FollowInvitation.where(following_id: id, status: :accepted)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :validatable

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :omniauthable,
         omniauth_providers: %i[spotify]

  def self.from_omniauth(params)
    find_or_create_by(uid: params[:uid]) do |new_user|
      new_user.provider = params[:provider]
      new_user.uid = params[:uid]
      new_user.email = params[:email]
      new_user.password = Devise.friendly_token[0, 20]
      new_user.nickname = params[:nickname]
      # .new_user.birthdate = params[:birthdate]
      new_user.country = params[:country]
      new_user.account_type = params[:account_type]
      new_user.account_product = params[:account_product]
      new_user.account_images = params[:account_images]
    end

    # If user already exist the find_or_create_by block won't be call
    # TODO: update user if already exist in db
    # if user.persisted?
    # user.update(
    #   email: params[:email],
    #   password: Devise.friendly_token[0, 20],
    #   nickname: params[:nickname],
    #   birthdate: params[:birthdate],
    #   country: params[:country],
    #   account_type: params[:account_type],
    #   account_product: params[:account_product],
    #   account_images: params[:account_images]
    # )

    # user
  end

  def username
    uid
  end
end
