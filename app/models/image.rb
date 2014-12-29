class Image < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: -> (controller, model) { controller && controller.current_user }

  belongs_to :document
  has_many :comments

  has_attached_file :foto, :styles => { :medium => "500x500>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :foto, :content_type => /\Aimage\/.*\Z/
  before_save :extract_dimensions
  serialize :dimensions

  def image?
    foto_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def extract_dimensions
    return unless image?
    tempfile = foto.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end

end
