class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_save { self.email = email.downcase }
  before_save { self.role ||= :member } #sets role to member if there is nothing

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  enum role: [:member, :admin, :chiefAdmin]

end
