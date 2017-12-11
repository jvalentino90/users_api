class ApplicationController < ActionController::API

  rescue_from Exception, with: :notify_exception

  def record_not_found
    render json: { error: 'Record not found' }, status: 404
  end

  def unprocessable_entity(errors)
    render json: { errors: errors }, status: 422
  end

  def notify_exception(exception)
    if exception.is_a?(ActiveRecord::RecordNotFound)
      record_not_found
    else
      render json: { error: "An error has ocurred" }, status: 500
    end
  end
end
