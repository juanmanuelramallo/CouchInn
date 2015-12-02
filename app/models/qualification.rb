class Qualification < ActiveRecord::Base
	 belongs_to :user
   belongs_to :couch

   validate :can_qualify
	 validates_presence_of :percentage

	 cattr_accessor :current_user

	def can_qualify
	 	if !(current_user.can_qualify?(couch))
	 		errors.add(:base, "Solo puedes calificar una vez por visita al couch deseado")
	 	end
	end



end
