class Qualification < ActiveRecord::Base
	 belongs_to :user

	 validates_presence_of :percentage
	 validates_uniqueness_of :couch_id, :scope => :user_id
end
