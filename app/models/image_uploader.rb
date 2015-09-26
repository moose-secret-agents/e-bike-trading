class ImageUploader

  # initalize Uploader with new Imgur Client
  def initialize
    @client = Imgur.new 'be637321cf3de65'
  end

  # returns url to uploaded image
  def upload(image)
    uploaded = @client.upload image
    uploaded.link
  end
end