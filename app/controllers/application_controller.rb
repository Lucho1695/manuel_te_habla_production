class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [image_files_attributes:
    [
      :id,
      :user_id,
      :principal_file,
      :image_file,
      :_destroy
    ]])
  end

  def record_activity(note)
    @activity = UserLog.new
    @activity.user = current_user
    @activity.note = note
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.params = params.inspect
    @activity.save
  end

  def record_activity_with_more_info(note, data)
    @activity = UserLog.new
    @activity.user = current_user
    @activity.note = note
    @activity.browser = request.env['HTTP_USER_AGENT']
    @activity.ip_address = request.env['REMOTE_ADDR']
    @activity.controller = controller_name
    @activity.action = action_name
    @activity.params = params.inspect
    @activity.have_more_description = true
    @activity.save
    @user_log_with = UserLogWith.new
    @user_log_with.user_log_id = @activity.id
    @user_log_with.data = data
    @user_log_with.save!
  end

end
