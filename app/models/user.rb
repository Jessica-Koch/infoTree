class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :skip_conf!
  after_initialize :set_default_role
  has_many :wikis

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :premium, :admin]

  def set_default_role
    self.role ||= :standard
  end
  def skip_conf!
    self.confirm if Rails.env.development?
  end
end
