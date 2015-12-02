class Message < ActiveRecord::Base
  belongs_to :user

  after_initialize :init

  default_scope {order('created_at DESC')}

  def init
    self.seen ||= false
  end

  def has_new_messages(user)
    return Message.where('user_id = ? and seen = ?', user.id, false).count
  end

  def get_icon

    case object # a_variable is the variable we want to compare
    when "couch"    #compare to 1
      return "glyphicon glyphicon-bed"
    when "payment"    #compare to 2
      return "glyphicon glyphicon-credit-card"
    when "qualification"
      return "glyphicon glyphicon-star"
    when "question"
      return "glyphicon glyphicon-question-sign"
    when "reservation"
      return "glyphicon glyphicon-bookmark"
    when "searching"
      return "glyphicon glyphicon-search"
    when "tipoc"
      return "glyphicon glyphicon-th-list"
    when "welcome"
      return "glyphicon glyphicon-thumbs-up"
    else
      return "glyphicon glyphicon-asterisk"
    end

  end

end
