class ImageController < ApplicationController

    ## Filters ##



    ## Methods ##

    # POST /images
    # Creates a new image
    def create
        image = Image.new(params_image) # Create a new image with the entered params
        image.base64 = "data:image/png;base64," + Base64.strict_encode64(File.read(image.content.path))
        
            if image.save
                image = Image.get_image_by_id(image.id)

                response = { content: image, message: "Image has been created successfully" } # Return the created image

                render json: response, status: 201
            else
                response = { error: "Wrong Data" }

                render json: response, status: 400 # Return 'bad request' and nil
            end
    end

    # GET /images
    # Show all the images
    def show
        images = Image.get_all_images # Obtain all the images from the model

        if images.length > 0 # If exist at least one image in DB
            response = { content: images, message: "Images has been obtained successfully" } # Return all the images

            render json: response, status: 200
        else # If not exist data
            response = { content: nil, message: "No images" }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /typeimages/:imageabletype
    # Show all the images corresponding to the type
    def show_by_type
        images = Image.get_all_type_images(params[:imageabletype]) # Obtain all the images corresponding to the type from the model

        if images.length > 0 # If exist at least one image in DB
            response = { content: images, message: "Images has been obtained successfully" } # Return all the images

            render json: response, status: 200
        else # If not exist data
            response = { content: nil, message: "No images corresponding to the type" }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /ownerimages/:imageableid
    # Show all the images corresponding to the owner id
    def show_by_owner
        images = Image.get_image_by_owner_id(params[:imageableid]) # Obtain all the images corresponding to the id from the model

        if images.length > 0 # If exist at least one image in DB
            response = { content: images, message: "Images has been obtained successfully" } # Return all the images

            render json: response, status: 200
        else # If not exist data
            response = { content: nil, message: "No images corresponding to the owner id" }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /typeownerimages/:imageabletype/:imageableid
    # Show all the images corresponding to the type and the owner id
    def show_by_type_and_owner
        images = Image.get_image_by_type_and_owner(params[:imageabletype], params[:imageableid]) # Obtain all the images corresponding to the type and the owner id from the model

        if images.length > 0 # If exist at least one image in DB
            response = { content: images, message: "Images has been obtained successfully" } # Return all the images

            render json: response, status: 200
        else # If not exist data
            response = { content: nil, message: "No images corresponding to the type and id owner" }

            render json: response, status: 204 # Return 'no content' and nil
        end
    end

    # GET /images/:id
    # Show the image corresponding to the id
    def show_by_id
        image = Image.get_image_by_id(params[:id]) # Obtain the image corresponding to the id

        if image != nil # If exist the image in DB
            response = { content: image, message: "Image has been obtained successfully" } # Return the corresponding image

            render json: response, status: 200
        else # If not exist data
            response = { error: "Image not found" }

            render json: response, status: 404 # Return 'not found'
        end
    end

    # DELETE /images/:id
    # Delete an existing image
    def delete
        image = Image.delete_image(params[:id]) # Delete an existing image

        if image != nil # If the image was deleted successfully
            response = { content: image, message: "Image has been deleted successfully" } # Return the corresponding image

            render json: response, status: 200
        else # If the image was not destroyed
            response = { error: "Image not found" }

            render json: response, status: 404 # Return 'not found'
        end
    end

    ## Allowed params ##

    def params_image
        params.permit(:id, :content, :imageableid, :imageabletype)
    end

end
