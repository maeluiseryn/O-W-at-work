class Notifier < ActionMailer::Base

      def support_notification(sender)
        @sender = sender
        attachments['rails.png'] = File.read(Rails.root.to_s+'/public/images/rails.png')
        mail(:to => "nicolas@onlywood.be",
             :from => sender.email,
           :subject => "New #{sender.support_type}")
      end
end


