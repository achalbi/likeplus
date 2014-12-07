class StaticPagesController < ApplicationController

  def home
  	@user = current_user
  	unless @user.nil?
  		@pictures = @user.pictures.nil? ? []: @user.pictures
  		@testimonials = @user.testimonials
  	    @uniq_badges =  @user.rels(dir: :incoming, type: :badges).each.map {|r| r.badgeType}.uniq
	    @all_badges = {}
	    @uniq_badges.each do |badge|
	      @all_badges[badge] = @user.rels(dir: :incoming, type: :badges).each.select{|r| r.badgeType == badge }.count
	    end
	    @my_badges = []
      @latitude = nil #'12.9715987'
      @longitude = nil #'77.5945627'
  	end
  end

  def help
  end
end
