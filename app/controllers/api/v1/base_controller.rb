class Api::V1::BaseController < ActionController::API
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_parameter_missing

  before_action :current_account

  respond_to :json

  def current_account
    @current_account ||= current_session.try(:account)
  end

  def current_session
    @current_session ||= get_session
  end

  def get_session
    session = Session.not_expired.find_by(access_token: request.headers['Access-Token'])
    render_unauthorized unless session

    set_access_token_to_header(session) if session.touch
    session
  end

  def set_access_token_to_header(session)
    response.headers['Access-Token'] = session.access_token
  end

  def render_not_found(e)
    render_error(404, 'NotFound', e.message)
  end

  def render_parameter_missing(e)
    render_error(422, 'ParameterMissing', e.message)
  end

  def render_unauthorized
    render_error(401, 'Unauthorized', 'Invalid access-token')
  end

  def render_error(status, type, message)
    json = { type: type, message: message }
    render json: json, status: status
  end

  def render_success(message)
    json = { message: message }
    render json: json, status: 200
  end
end