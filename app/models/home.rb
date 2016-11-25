class Home < ActiveRecord::Base
  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  has_many :tags, through: :home_tags
  
  filterrific(
  
  available_filters: [
    :rating
    
  ]
)

scope :rating, lambda { |ratings|
  where(rating: [*ratings])
}

def self.options_for_select
  order('rating').map { |e| [e.rating, e.id] }
end

  
  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['address ILIKE ?', "%#{search}%"])
  #     #@homes = Home.search(params[:search])
  #   else
  #     find(:all)
  #     #@homes = Home.all
  #   end    
  # end
  
  def self.search(search)
    where("address LIKE ?", "%#{search}%")
  end  
  
  def self.filter(filter)
    where(address_id: filter)
    
  end
end