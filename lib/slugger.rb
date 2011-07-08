class Slugger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    if request.path =~ %r{/r/(.+)} && post = Post.find_by_slug($1)
      location = "/posts/#{post.id}"
      [
        301,
        { "Location" => location, "Content-Type" => "text/plain" },
        ["Redirecting to #{location}"]
      ]
    else
      @app.call(env)
    end
  end
end