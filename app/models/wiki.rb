class Wiki < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

end
