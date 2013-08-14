class LiveChatsController < ApplicationController

  def new_chat
    @admins = AdminUser.select(:id, :first_name, :last_name).where(role: 'manager', status: 'online').order('random()')
    @live_chat = LiveChat.new
    chat = (render_to_string :partial => 'shared/live_chat').delete("\n").gsub(/["]/, "'").gsub(/ {2,}/, ' ')
    render js: "$('body').append(\"#{chat}\");"
  end

  def create_chat
    if session[:chat_id].blank?
      unless params[:message].blank?
        message = ChatMessage.new(:body => params[:message], :is_admin => false, :live_chat_id => 1)
        if message.valid?
          @live_chat = LiveChat.new(live_chat_params)
          if @live_chat.save
            session[:chat_id] = @live_chat.id
            message.live_chat = @live_chat
            if message.save
              gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              channel = 'presence-' + @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              Webs.pusher
              Webs.notify(:send_chat_message, channel, 'msg-event', { :user_id => session[:user_id],
                                                                      message: message.body,
                                                                      name: @live_chat.guest_name,
                                                                      is_admin: message.is_admin,
                                                                      date: message.created_at.to_i})
              @live_chat.admin_user.update_attribute(:status, 'chat')
            else
              redirect_to :back, :notice => 'Invalid Message'
            end
            chat = (render_to_string :partial => 'shared/live_chat').delete("\n").gsub(/["]/, "'").gsub(/ {2,}/, ' ')
            render js: "$('#live_chat').replaceWith(\"#{chat}\");"
          else
            redirect_to :back, :alert =>  'Chat start error! Invalid name !'
          end
        else
          redirect_to :back, :alert =>  'error!'
        end
      else
        redirect_to :back, :alert => 'Invalid Message'
      end
    else
      redirect_to :back, :alert => 'Chat already start'
    end
  end

  def create_chat_contact
    if session[:chat_id].blank?
      unless params[:message].blank?
        message = ChatMessage.new(:body => params[:message], :is_admin => false, :live_chat_id => 1)
        if message.valid?
          @live_chat = LiveChat.new(live_chat_params)
          if @live_chat.save
            session[:chat_id] = @live_chat.id
            message.live_chat = @live_chat
            if message.save
              gon.current_admin_channel = @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              channel = 'presence-' + @live_chat.admin_user.first_name+'-'+@live_chat.admin_user.last_name
              Webs.pusher
              Webs.notify(:send_chat_message, channel, 'msg-event', { :user_id => session[:user_id],
                                                                      message: message.body,
                                                                      name: @live_chat.guest_name,
                                                                      is_admin: message.is_admin,
                                                                      date: message.created_at.to_i})
              @live_chat.admin_user.update_attribute(:status, 'chat')
            end
            chat = (render_to_string :partial => 'contact/chat').delete("\n").gsub(/["]/, "'").gsub(/ {2,}/, ' ')
            render js: "$('#contact_live_chat').replaceWith(\"#{chat}\");"
          end
        end
      end
    end
  end

  def send_msg
    unless params[:message].blank?
      message = ChatMessage.new
      message.body = params[:message]
      message.is_admin = false
      message.live_chat_id = session[:chat_id]
      if message.save
        chat = LiveChat.find(session[:chat_id])
        gon.current_admin_channel = chat.admin_user.first_name+'-'+chat.admin_user.last_name
        channel = 'presence-' + chat.admin_user.first_name+'-'+chat.admin_user.last_name #chat.admin_user.email
        Webs.pusher
        Webs.notify(:send_chat_message, channel, 'msg-event', { :user_id => session[:user_id],
                                                                message: message.body,
                                                                name: @live_chat.guest_name,
                                                                is_admin: message.is_admin,
                                                                date: message.created_at.to_i})
      end
    end
    render text: 'ok!'
  end

  def chat_close
    live_chat = LiveChat.includes(:admin_user).find(session[:chat_id])
    live_chat.admin_user.update_attribute(:status, 'online')
    session[:chat_id] = nil
    render text: 'ok!'
  end

  def contact_chat_close
    live_chat = LiveChat.includes(:admin_user).find(session[:chat_id])
    live_chat.admin_user.update_attribute(:status, 'online')
    session[:chat_id] = nil
    render js: "location.reload();"
  end

  protected

  def live_chat_params
    params.require(:live_chat).permit(:guest_name, :admin_id)
  end

end