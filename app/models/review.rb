class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :category
    validates :user_id, presence: true
    validates :created_at, presence: true 
    validates :updated_at, presence: true 
    validates :title, presence: true
    validates :content, presence: true 
end