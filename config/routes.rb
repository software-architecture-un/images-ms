Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ## Image endpoints ##

  post 'images' => 'image#create' # Create a new image (POST)
  get 'images' => 'image#show' # Return all the images (GET)
  get 'typeimages/:imageabletype' => 'image#show_by_type' # Return all the images corresponding to the type (GET)
  get 'ownerimages/:imageableid' => 'image#show_by_owner' # Return all the images corresponding to the owner id (GET)
  get 'images/:id' => 'image#show_by_id', constraints: { id: /[0-9]+/ } # Return the image corresponding to the id (GET)
  get 'base64/:id' => 'image#show_base64', constraints: { id: /[0-9]+/ } # Return the image corresponding (Base64) to the id (GET)
  delete 'images/:id' => 'image#delete', constraints: { id: /[0-9]+/ } # Delete an existing image (DELETE)

  ## Handle routes exceptions ##
  
  get '*unmatched_route' => 'application#route_not_found' # Handle the exceptions associates to not find the requested route (GET)

end
