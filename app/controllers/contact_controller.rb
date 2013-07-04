class ContactController < ApplicationController

  def index
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => 'Message was successfully sent.')
    else
      flash.now[:error] = 'Form invalid. Please check errors bellow'
      render :index
    end
  end

end
