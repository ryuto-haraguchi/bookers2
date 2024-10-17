class User < ApplicationRecord
  has_many :books
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    def get_profile_image(width, height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      profile_image.variant(resize_to_limit: [width, height]).processed
    end

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if name = conditions.delete(:name)
        where(conditions.to_h).where(["name = :value", { value: name }]).first
      end
    end
  
  GUEST_USER_EMAIL = 'guest@example.com'

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = 'ゲストユーザー'
      end
    end

    def guest_user?
      email == GUEST_USER_EMAIL
    end

    validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
    validates :introduction, length: { maximum: 50 }
end
