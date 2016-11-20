class Home < ActiveRecord::Base
  has_many :favorites
  has_many :comments

  has_many :users, through: :favorites
  
  def self.search(search)
    if search
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
      @homes = Home.search(params[:search]).order('created_at_DESC')
    else
      #find(:all)
      @homes = Home.all.order('created_at_DESC')
    end    
  end
  
  # def self.search(search)
  #   where("address ILIKE ?", "%#{search}%")
  # end  
end