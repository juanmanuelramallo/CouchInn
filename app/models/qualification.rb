class Qualification < ActiveRecord::Base
	 belongs_to :user
   	 belongs_to :couch

	 validates_presence_of :percentage
	 validates_uniqueness_of :couch_id, :scope => :user_id
	 validate :was_in

	 def was_in
	 	r = Reservation.where('couch_id = ? and user_id = ?', couch_id, user_id)
	 	r.each do |res|
	 		if ( res.confirmed == false )
	 			errors.add(:percentage, "el usuario tuvo que estar en ese couch.")
	 		end
	 	end
	 end
end
