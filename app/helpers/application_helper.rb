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
    
    def multiply(a, b)
        return a*b
    end
    
    def zeroifnil(a)
        if a.nil?
            return 0
        else
            return a
        end
    end
end
