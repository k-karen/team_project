class ApplicationController < ActionController::Base

  def test
    x = (1..100).to_a.sample(3)
    render json: { message: "Hello World #{x}" }
  end
end
