class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error
  before_action :authorize


  def authorize
    @user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @user
  end


  def unprocessable_entity_error(problem)
    render json: { errors: problem.record.errors.full_messages }, status: :unprocessable_entity
  end
end
