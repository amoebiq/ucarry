class ImageService

  def self.presign(prefix, filename, limit: limit)

    puts "Here in upload service"
    extname = File.extname(filename)
    filename = "#{SecureRandom.uuid}#{extname}"
    upload_key = Pathname.new(prefix).join(filename).to_s

    creds = Aws::Credentials.new('AKIAISQYBGKTUM43VBDQ', 'If/Le4GoFE/Q/kFnYXBgkFbKxLmmxPBioNyC9p6c')
    s3 = Aws::S3::Resource.new(region: 'us-east-1', credentials: creds)
    obj = s3.bucket('karrierbaydevelopment').object(upload_key)

    params = { acl: 'public-read' }
    params[:content_length] = limit if limit

    {
        presigned_url: obj.presigned_url(:put, params),
        public_url: obj.public_url
    }
  end

end