class Wiki < ApplicationRecord
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }
  def public?
    Wiki.where(private: false)
  end
end
