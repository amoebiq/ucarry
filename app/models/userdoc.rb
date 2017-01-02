class Userdoc < ActiveRecord::Base

  has_attached_file :picture

  before_save :attach_file

  after_save :save_file

  has_attached_file :picture,
                    :storage => :s3, :s3_protocol => 'https',
                    :bucket => 'ucarrytest',
                    :url => '/docs/:id/:basename_:id.:extension',
                    :s3_credentials => {
                        :access_key_id => ENV['S3_ACCESS_KEY'],
                        :secret_access_key => ENV['S3_SECRET']

                    },
                    :path => '/docs/:id/:basename_:id.:extension',
                    :default_url => "",
                    :styles => {}



  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  validates_attachment_file_name :picture, :matches => [/png\Z/, /jpe?g\Z/]

  def attach_file

    p 'in attach files'


  end


  def save_file

    p 'here in after save'
    self.url = self.picture.url

    p self.picture.url

  end

end
