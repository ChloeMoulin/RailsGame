class Game < ActiveRecord::Base

  attr_accessible :company, :description, :grade, :name, :platform, :released_at, :cover_filename, :cover

  has_and_belongs_to_many :tournaments
  has_many :matches

  validates :name,  :presence => true,
                    :format => {:with => /^[a-zA-Z0-9_ ]{5,20}$/i},
                    :length => {:within => 1..20}

  validates :description, :presence => true,
                          :format => {:with => /^[a-zA-Z0-9 ]{10,200}$/i},
                          :length => {:within => 10..200}

  validates :company, :presence => true,
                      :format => {:with => /^[a-zA-Z0-9_ ]{5,20}$/i},
                      :length => {:within => 1..20}

  validates :grade, :presence => true,
                    :numericality =>  { only_integer: true, greater_than: -1, less_than: 11 }

  validates :platform,  :presence => true, 
                        :format => {:with => /^[a-zA-Z0-9 ]{3,20}$/i}

  validates :released_at, :presence => true,
                          :format => {:with => /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/i}


  mount_uploader :cover, CoverUploader 

end
  