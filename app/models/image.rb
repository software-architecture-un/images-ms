class Image < ApplicationRecord

    ## Uploader ##

    mount_uploader :content, ContentUploader

    ## Queries ##

    # Query that gets all the images
    def self.get_all_images
        self.all
    end

    # Query that gets all the images corresponding to a type
    def self.get_all_type_images(current_type)
        self.where(imageabletype: current_type)
    end

     # Query that gets all the images corresponding to a owner
    def self.get_image_by_owner_id(current_id)
        self.where(imageableid: current_id)
    end

    # Query that gets the image corresponding to the id
    def self.get_image_by_id(current_id)
        self.where(id: current_id).first
    end

    # Query that deletes an existing image record in DB
    def self.delete_image(id_image)
        image = self.where(id: id_image).first

        if image && image.destroy # If the image was deleted successfully
            return image # Return the deleted image
        else
            return nil # Return null if the image was not deleted
        end
    end

    ## Associations ##



    ## Validations ##

    validates :content, presence: true # Mandatory
    validates :imageableid, presence: true, numericality: { only_integer: true } # Mandatory
    validates :imageabletype, presence: true # Mandatory
    
end
