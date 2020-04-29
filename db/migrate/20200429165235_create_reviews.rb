class CreateReviews < ActiveRecord::Migration
  def change
      create_table :reviews do |t|
        t.string :title 
        t.timestamp :date
        t.string :review  
      end   
  end
end
