class StaticController < ApplicationController
  layout 'application'

  def now
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def zipplot
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

end
