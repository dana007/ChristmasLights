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

  has_attached_file :image, :styles => { :small => "150x150>" }
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  has_many :tags, through: :home_tags

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :search_query,
          :with_city,
          :with_state,
          :with_neighborhood,
          :with_user_id,
          :with_home_id
      ]
  )

  # default for will_paginate
  self.per_page = 10

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

  scope :with_home_id, lambda { |home_ids|
    where(id: [*home_ids])
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("homes.created_at #{direction}")
      when /^rating_/
        order("homes.rating #{direction}")
      else
        raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
        terms.map {
          or_clauses = [
              "LOWER(homes.title) LIKE ?",
              "LOWER(homes.description) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  def self.options_for_select
    order('rating').map { |e| [e.rating, e.id] }
  end

  def self.options_for_sorted_by
    [
        ['Post date (newest first)', 'created_at_desc'],
        ['Post date (oldest first)', 'created_at_asc'],
        ['Rating (highest first)', 'rating_desc'],
        ['Rating (lowest first)', 'rating_asc']
    ]
  end

  def self.city_options_for_select
    order('LOWER(city)').map{|e| [e.city]}.uniq - [[''], [nil]]
  end

  def self.city_options_for_select_homes(home_ids)
    where(id: home_ids).order('LOWER(city)').map{|e| [e.city]}.uniq - [[''], [nil]]
  end

  def self.city_options_for_select_user(user_id)
    where(user_id: user_id).order('LOWER(city)').map{|e| [e.city]}.uniq - [[''], [nil]]
  end

  def self.state_options_for_select
    order('LOWER(state)').map{|e| [e.state]}.uniq - [[''], [nil]]
  end

  def self.state_options_for_select_homes(home_ids)
    where(id: home_ids).order('LOWER(state)').map{|e| [e.state]}.uniq - [[''], [nil]]
  end

  def self.state_options_for_select_user(user_id)
    where(user_id: user_id).order('LOWER(state)').map{|e| [e.state]}.uniq - [[''], [nil]]
  end

  def self.neighborhood_options_for_select
    order('LOWER(neighborhood)').map{|e| [e.neighborhood]}.uniq - [[''], [nil]]
  end

  def self.neighborhood_options_for_select_homes(home_ids)
    where(id: home_ids).order('LOWER(neighborhood)').map{|e| [e.neighborhood]}.uniq - [[''], [nil]]
  end

  def self.neighborhood_options_for_select_user(user_id)
    where(user_id: user_id).order('LOWER(neighborhood)').map{|e| [e.neighborhood]}.uniq - [[''], [nil]]
  end

  def self.set_per_page(per_page)
    self.per_page = per_page
  end
 
  def decorated_created_at
    created_at.to_date.to_s(:long)
  end
end