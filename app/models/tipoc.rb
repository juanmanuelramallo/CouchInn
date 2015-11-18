class Tipoc < ActiveRecord::Base
  validates :tipo, presence: true
  default_scope -> {order("created_at")}
end
