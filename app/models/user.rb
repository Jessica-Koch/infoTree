class User < ApplicationRecord
  after_create :skip_conf!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def skip_conf!
    self.confirm if Rails.env.development?
  end
end
