class Document < ActionMailer::Base
   def fiche_de_rendez_vous(project)
        @project=project
        attachments['rails.png'] = File.read(Rails.root.to_s+'/public/images/rails.png')
        mail(:to => "nicolas@onlywood.be",
        :from =>"n0st4lg1af0r1nf1n1ty@gmail.com",
           :subject => "Nouvelle fiche de rendez-vous ")
   end

   def sav_form(project)
        @project=project
        attachments['Formulaire_de_SAV.pdf'] = File.read(Rails.root.to_s+'/public/data/documents/Formulaire_de_SAV.pdf')
        mail(:to => @project.client.contacts.find_by_genre('Email').contact_data ,# if more than one email must check .....
        :from =>"n0st4lg1af0r1nf1n1ty@gmail.com",
        :subject => "Formulaire de service Apres-ventes ")
      end
end
