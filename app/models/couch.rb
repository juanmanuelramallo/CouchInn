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

  has_attached_file :photo, styles: { original: "600x600>" ,medium: "300x300>" ,small: "150x150>" }, url: "/assets/products/:id/:style/:basename.:extension", path: ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  validates_attachment_size :photo, less_than: 2.megabytes, allow_blank: true
  validates_attachment_content_type :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']




end

