class Review < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :date, presence: true 
    validates :title, presence: true
    validates :review, presence: true 
end