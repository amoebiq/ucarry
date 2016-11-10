class SenderDetail < ActiveRecord::Base

  attr_accessor :image

  validates :email_id , :presence=>true
  validates :phone , :presence=>true , :uniqueness =>true
  validates :first_name, :presence=>true
  validates :last_name , :presence=>true

  before_save :decode_picture_data, :if => :picture_data_provided?



  has_attached_file :avatar,
                    :storage => :s3, :s3_protocol => 'https',
                    :bucket => 'karrierbaydevelopment',
                        :url => '/user/:id/:basename_:id.:extension',
      :s3_credentials => {
      :access_key_id => '',
          :secret_access_key => ''

  },
      :path => '/user/:id/:basename_:id.:extension',
      :default_url => "",
                    :styles =>
                        { :thumb => '150x150#'}

  #validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  private

  def picture_data_provided?
    !self.img_link.blank?
  end


  def decode_picture_data
    # If cover_image_data is set, decode it and hand it over to Paperclip
    p "in decoding image..."
    data = StringIO.new(Base64.decode64(self.img_link))
    data.class.class_eval { attr_accessor :original_filename, :content_type }
    data.original_filename = SecureRandom.hex(16) + ".png"
    data.content_type = "image/png"
    self.avatar = data
    self.img_link = self.avatar.url
  end

end
