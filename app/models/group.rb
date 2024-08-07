# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image
# オーナーは？
  def is_owned_by?(user)
    owner.id == user.id
  end
end
