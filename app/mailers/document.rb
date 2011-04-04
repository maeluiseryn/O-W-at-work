class Document < ActionMailer::Base
   def fiche_de_rendez_vous(project)
        @project=project
        attachments['rails.png'] = File.read(Rails.root.to_s+'/public/images/rails.png')
        mail(:to => "nicolas@onlywood.be",
        :from =>"n0st4lg1af0r1nf1n1ty@gmail.com",
           :subject => "Nouvelle fiche de rendez-vous ")
      end
end
