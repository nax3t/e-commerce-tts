class Product < ApplicationRecord
    #still unclear on purpose for this. Looks like it styles the specified attribute.
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
	
	#sets up a relationship
  belongs_to :category
end
