class Home < ActiveRecord::Base
  attr_accessor :title, :address, :rating, :user_id
  
  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  has_many :tags, through: :home_tags
  
  filterrific(
  default_filter_params: {rating: 'created_at_desc'},
  available_filters: [
    :state,
    :city,
    :rating
    
  ]
)
scope :with_state, lambda { |states|
  where(state: [*states])
}

scope :with_city, lambda { |cities|
  where(city: [*cities])
}

scope :with_rating, lambda { |ratings|
  where(rating: [*ratings])
}

def self.options_for_select
  order('state').map { |e| [e.state, e.id] }
end

# def self.options_for_sorted_by
#     [
#       ['State (a-z)', 'state_asc'],
#       ['City (a-z)', 'city_asc'],
#       ['Ratings (1-5)', 'rating_asc']
#     ]

# end

  
  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['address ILIKE ?', "%#{search}%"])
  #     #@homes = Home.search(params[:search])
  #   else
  #     find(:all)
  #     #@homes = Home.all
  #   end    
  # end
  
  # def self.search(search)
  #   where("address LIKE ?", "%#{search}%")
  # end  
  
  # def self.filter(filter)
  #   where(address_id: filter)
    
  # end
end