class Home < ActiveRecord::Base
  # Database Columns:
  # id: integer
  # title: string
  # rating: integer
  # user_id: integer
  # created_at: timestamp
  # updated_at: timestamp
  # street_address: string
  # city: string
  # state: string
  # zip_code: string
  # neighborhood: string
  # image_file_name: string
  # image_content_type: string
  # image_file_size: integer
  # image_updated_at: timestamp

  attr_accessor :rating, :user_id
  
  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  has_many :tags, through: :home_tags

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :with_rating,
          :with_city,
          :with_state,
          :with_neighborhood,
          :with_user_id
      ]
  )

  # default for will_paginate
  self.per_page = 10

  scope :with_rating, lambda { |ratings|
    where(rating: [*ratings])
  }

  scope :with_city, lambda { |cities|
    where(city: [*cities])
  }

  scope :with_state, lambda { |states|
    where(state: [*states])
  }

  scope :with_neighborhood, lambda { |neighborhoods|
    where(neighborhood: [*neighborhoods])
  }

  scope :with_user_id, lambda { |user_id|
    where(user_id: user_id)
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("homes.created_at #{direction}")
      else
        raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  def self.options_for_select
    order('rating').map { |e| [e.rating, e.id] }
  end

  def self.options_for_sorted_by
    [
        ['Post date (newest first)', 'created_at_desc'],
        ['Post date (oldest first)', 'created_at_asc']
    ]
  end

  def self.city_options_for_select
    order('LOWER(city)').map{|e| [e.city]}
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
  
  # def self.search(search)
  #   where("address LIKE ?", "%#{search}%")
  # end
  
  # def self.filter(filter)
  #   where(address_id: filter)
  # end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end
end