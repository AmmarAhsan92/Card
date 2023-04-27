class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end

  rescue_from ActiveRecord::RecordNotDestroyed do
    flash[:notice] = 'Something went Wrong...'
    redirect_to root_url
  end
end
