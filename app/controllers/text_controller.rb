class TextController < ApplicationController

  require "i18n"

  def cleanString(str)
    contain = I18n.transliterate(str)
    contain.gsub!(/[^0-9A-Za-z]/, ' ')
    contain.downcase!
    return contain.split
  end

  def tags(arr, id)
    booking  = ['reserver', 'reserve', 'book', 'rendez', 'appointement', 'reservation', 'booking']
    hours = ['heure', 'hour', 'hours', 'ouverture', 'opening']
    address = ['adresse', 'emplacement', 'location', 'address']

    # Location TAG ---------
    if arr.include?('vieux')
      tag = Status.find_by(sender: id).tags << "vieuxMontreal"
      Status.where(:sender => id).update(tags: tag)
    elsif arr.include?('marie')
      tag = Status.find_by(sender: id).tags << "villeMarie"
      Status.where(:sender => id).update(tags: tag)
    elsif arr.include?('mile')
      tag = Status.find_by(sender: id).tags << "mileEnd"
      Status.where(:sender => id).update(tags: tag)
    elsif arr.include?('dix30') or arr.include?('quartier')
      tag = Status.find_by(sender: id).tags << "DIX30"
      Status.where(:sender => id).update(tags: tag)
    elsif arr.include?('rudsak')
      tag = Status.find_by(sender: id).tags << "rudsak"
      Status.where(:sender => id).update(tags: tag)
    elsif arr.include?('academy')
      tag = Status.find_by(sender: id).tags << "academy"
      Status.where(:sender => id).update(tags: tag)
    end

    # Intent TAG
    if (arr & booking).empty? == false
      tag = Status.find_by(sender: id).tags << "booking"
      Status.where(:sender => id).update(tags: tag)
    elsif (arr & hours).empty? == false
      tag = Status.find_by(sender: id).tags << "opening"
      Status.where(:sender => id).update(tags: tag)
    elsif (arr & address).empty? == false
      tag = Status.find_by(sender: id).tags << "location"
      Status.where(:sender => id).update(tags: tag)
    end

  end

  def hashValid
    # mapping = { :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1,
    #             :vieux => :method_1
    # }



  end



end
