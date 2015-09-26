class ImageUploader

  # initalize Uploader with new Imgur Client
  def initialize
    @client = Imgur.new 'be637321cf3de65'
  end

  # returns url to uploaded image
  def upload(image)
    imgur_image = Imgur::LocalImage.new(image, title: 'null')
    uploaded = @client.upload imgur_image
    uploaded.link
  end
end