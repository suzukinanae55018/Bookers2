class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    if user.present?
      favorites.exists?(user_id: user.id)
    else
      false
    end
  end

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end
