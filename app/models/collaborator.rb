class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki

  validates :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => :wiki_id
  validates :role, presence: true

  enum role: [:owner, :member]
end
