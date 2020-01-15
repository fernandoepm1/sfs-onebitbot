class Faq < ActiveRecord::Base
  validates :question, :answer, presence: true

  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
end