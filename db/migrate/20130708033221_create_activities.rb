class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|

    	t.integer		'user_id'
    	t.text			'description'
    	t.string		'name'

      t.timestamps
    end
  end
end
