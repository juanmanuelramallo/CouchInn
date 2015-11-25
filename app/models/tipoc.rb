class Tipoc < ActiveRecord::Base
  validates :tipo, presence: true, uniqueness: { case_sensitive: false }
  default_scope -> {order("created_at")}
end
