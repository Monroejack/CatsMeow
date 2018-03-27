class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
#associations
         has_many :tweets
#CarrierWave
         mount_uploader :avatar, AvatarUploader
         #validations
        validates :username, presence: true, uniqueness: { case_sensitive: false }
        validates :username, length: { minimum: 3, maximum: 20 }

        serialize :following, Array

        def followers
          followers = []
          User.all.each do |u|
            followers << u if u.following.include? self.id
          end
          followers
        end

        def username
          "@#{super}"
        end
end
