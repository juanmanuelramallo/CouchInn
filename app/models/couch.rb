class Couch < ActiveRecord::Base
  belongs_to :user
  has_many :fotos
  has_many :reservations

  after_initialize :init

  def init
    self.eliminado ||= false
  end

  def is_owner?(user)
    return user_id == user.id
  end

end

