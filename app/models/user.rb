# frozen_string_literal: true

class User < ApplicationRecord
  include AvatarUploader::Attachment(:avatar)

  has_many :comments, dependent: :destroy
  has_many :feeds, dependent: :destroy
  has_many :follow_invitations,
           foreign_key: 'follower_id',
           class_name: 'FollowInvitation',
           dependent: :destroy
  has_many :following_invitations,
           foreign_key: 'following_id',
           class_name: 'FollowInvitation',
           dependent: :destroy
  has_many :likes, class_name: 'Like', dependent: :destroy
  has_many :notifications,
           foreign_key: 'destinatary_id',
           class_name: 'Notification',
           dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :posts_users, through: :posts, source: :postable, source_type: 'Posts::User'

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

  def self.class_name
    self.class.demodulize.downcase
  end

  def feeds_visiable
    Feed.where(user_id: id, visiable: true)
  end

  def followers
    FollowInvitation.where(follower_id: id, status: :accepted)
  end

  def followings
    FollowInvitation.where(following_id: id, status: :accepted)
  end

  def follow(user)
    return if user.nil? || user.id == id

    @follow ||= FollowInvitation.find_by(follower: self, following: user)
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

  ALLOWED_TYPES = %w[spotify].freeze

  validates :provider,
            presence: true,
            inclusion: { in: ALLOWED_TYPES },
            uniqueness: { scope: :uid }

  validates :uid, presence: true
  validates :nickname, presence: true

  def self.from_omniauth(params)
    user = User.find_by(provider: params[:provider], uid: params[:uid])

    if user
      user.update(
        email: params[:email],
        country: params[:country],
        account_type: params[:account_type],
        account_product: params[:account_product],

        # trackable
        sign_in_count: user.sign_in_count + 1,
        last_sign_in_ip: user.current_sign_in_ip,
        current_sign_in_ip: params[:current_sign_in_ip],
        last_sign_in_at: user.current_sign_in_at,
        current_sign_in_at: Time.now
      )

      user
    else
      User.create(
        provider: params[:provider],
        uid: params[:uid],
        email: params[:email],
        password: Devise.friendly_token[0, 20],
        nickname: params[:nickname].present? ? params[:nickname] : params[:uid],
        # .birthdate: params[:birthdate]
        country: params[:country],
        account_type: params[:account_type],
        account_product: params[:account_product],
        account_images: params[:account_images],

        # trackable
        sign_in_count: 1,
        current_sign_in_ip: params[:current_sign_in_ip],
        last_sign_in_ip: nil,
        current_sign_in_at: Time.now,
        last_sign_in_at: nil
      )
    end
  end

  def username
    uid
  end
end
