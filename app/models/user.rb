class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :skip_conf!
  after_initialize :set_default_role

  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  enum role: [:standard, :premium, :admin]


  def set_default_role
    self.role ||= :standard
  end

  def skip_conf!
    self.confirm if Rails.env.development?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def last_owner?(wiki)
    wiki.collaborators.where(role: 0).count == 1
  end
end
