class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride 
    if enough_tickets? && tall_enough?
      update_user
    elsif !enough_tickets? && tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif enough_tickets? && !tall_enough?
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    elsif !enough_tickets? && !tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    end
  end
  
  def enough_tickets?
    self.user.tickets > self.attraction.tickets.to_i   
  end
  
  def tall_enough?
    self.user.height > self.attraction.min_height
  end

  def update_user
    self.user.update(
      tickets: self.user.tickets - self.attraction.tickets.to_i,  
      happiness: self.user.happiness + self.attraction.happiness_rating,
      nausea: self.user.nausea + self.attraction.nausea_rating 
    )
  end



end
