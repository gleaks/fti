# frozen_string_literal: true

module ApplicationHelper
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def multiply(a, b)
    a * b
  end

  def zeroifnil(a)
    if a.nil?
      0
    else
      a
    end
  end

  def slug(a)
    if a == 'Confirmed Order'
      a.split(' ')[0].downcase + ' math'
    else
      a.split(' ')[0].downcase
    end
  end

  def iconify(a)
    if a == true
      return '<i class="material-icons">check</i>'.html_safe
    else
      return '<i class="material-icons">close</i>'.html_safe
    end
  end

  def checkactive(a)
    'active' if a == 'Confirmed Order'
  end

  def checkhidden(a, b)
    if b == 'style'
      'visibility:collapse' if a == false
    else
      if a == true
        'visible'
      else
        'hidden'
      end
    end
  end
end
