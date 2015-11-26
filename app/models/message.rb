class Message < ActiveRecord::Base
  belongs_to :user

  after_initialize :init

  def init
    self.seen ||= false
  end
end
