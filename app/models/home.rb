class Home < ActiveRecord::Base
  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  has_many :tags, through: :home_tags
  
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
end