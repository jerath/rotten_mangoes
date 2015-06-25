class Movie < ActiveRecord::Base
  has_many :reviews
  mount_uploader :image, ImageUploader

  scope :search, ->(query_string) { where("title LIKE ? OR director LIKE ?", "%#{query_string}%", "%#{query_string}%") }

  scope :under_90_minutes, -> { where("runtime_in_minutes < 90") }
  scope :between_90_and_120_minutes, -> { where("runtime_in_minutes BETWEEN 90 AND 120") }
  scope :over_120_minutes, -> { where("runtime_in_minutes > 120") }


  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  def review_average
    if reviews.size == 0
      return 0
    else
      return reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end