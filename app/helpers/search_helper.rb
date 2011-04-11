module SearchHelper
  def model_list
     [['Clients',Client ], ['Projets' ,Project] ,['Addresses',Address ],[ 'Fichiers',UploadedFile],[ 'Contacts',Contact]]
  end
  def per_page_result
    [['10'],['20'],['50'],['100']]
  end
end
