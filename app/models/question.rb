class Question < ActiveRecord::Base
  belongs_to :couch
  belongs_to :user

 after_initialize :init

 validates :question, presence: true

 validates :answer, presence: true, on: :update

 default_scope { order('created_at DESC') }

  def init
    self.answer ||= " -- Aún sin responder"
  end

  def is_owner?(user)
    return user_id == user.id
  end

end
