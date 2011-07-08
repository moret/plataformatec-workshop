class SlugsController
  def call(env)
    request = ActionDispatch::Request.new(env)
    post = Post.find_by_slug!(request.params[:slug])
    location = "/posts/#{post.id}"
    [
      301,
      { "Location" => location, "Content-Type" => "text/plain" },
      ["Redirecting to #{location}"]
    ]
  end
end