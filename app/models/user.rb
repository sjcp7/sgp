class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile, polymorphic: true

  def admin?
    profile_type == 'Admin'
  end

  def teacher?
    profile_type == 'Teacher'
  end
end
