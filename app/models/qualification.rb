class Qualification < ActiveRecord::Base
	 belongs_to :user
   belongs_to :couch

	 validates_presence_of :percentage
	 #validates_uniqueness_of :couch_id, :scope => :user_id
end
