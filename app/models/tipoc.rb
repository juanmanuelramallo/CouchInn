class Tipoc < ActiveRecord::Base
  validates :tipo, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z]+\z/, message: "Solo se permiten letras"  }
  default_scope -> {order("created_at")}
end
