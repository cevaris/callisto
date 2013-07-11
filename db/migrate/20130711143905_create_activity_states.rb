class CreateActivityStates < ActiveRecord::Migration
  def self.up
    
    create_table :activity_states do |t|
    	t.string :name
    	t.string :thumbnail
    end

    # Load in seed data
    # load "#{Rails.root}/db/seeds.rb"

  end


  def self.down
  	drop_table :activity_states
  end
end
