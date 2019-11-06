class ApplicationController < ActionController::Base
  include SessionsHelper

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  rescue_from Forbidden, with: :rescue403

  def rescue403(e)
    @exception = e
    render 'errors/403.html', status: 403, layout:  false
  end

end
