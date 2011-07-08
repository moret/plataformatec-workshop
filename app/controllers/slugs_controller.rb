# Extending from Metal to better performance
class SlugsController < ActionController::Metal
  include ActionController::Redirecting

  def check
    post = Post.find_by_slug!(params[:slug])
    redirect_to "/posts/#{post.id}"
  end
end

# Old uglier code
# class SlugsController
#   def call(env)
#     request = ActionDispatch::Request.new(env)
#     post = Post.find_by_slug!(request.params[:slug])
#     location = "/posts/#{post.id}"
#     [
#       301,
#       { "Location" => location, "Content-Type" => "text/plain" },
#       ["Redirecting to #{location}"]
#     ]
#   end
# end

