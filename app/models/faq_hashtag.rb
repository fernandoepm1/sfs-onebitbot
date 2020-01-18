class FaqHashtag < ActiveRecord::Base
  validates :faq_id, :hashtag_id, presence: true

  belongs_to :faq
  belongs_to :hashtag
end
