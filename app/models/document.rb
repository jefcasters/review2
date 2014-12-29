class Document < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller && controller.current_user }

  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :comments, through: :images
  # , dependent :destroy
  # attr_accessor :image
  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
