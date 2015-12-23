module Spree
  class OrderMailer < BaseMailer
    def confirm_email(*args)
      confirm_cancel_email(true,*args)
    end

    def cancel_email(*args)
      confirm_cancel_email(false,*args)
    end
    
    private
    
    def confirm_cancel_email(is_confirm, order, resend = false)
      @order = order.respond_to?(:id) ? order : Spree::Order.find(order)
      subject = (resend ? "[#{Spree.t(:resend).upcase}] " : '')
      subject += "#{Spree::Store.current.name} #{Spree.t("order_mailer.#{is_confirm ? "confirm" : "cancel")}_email.subject")} ##{@order.number}"
      mail(to: @order.email, from: from_address, subject: subject)
    end
  end
end
