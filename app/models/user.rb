class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if name = conditions.delete(:name)
        where(conditions.to_h).where(["name = :value", { value: name }]).first
      end
    end
end
