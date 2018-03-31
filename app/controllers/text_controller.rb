class TextController < ApplicationController

  require "i18n"

  def cleanString(str)
    contain = I18n.transliterate(str)
    contain.gsub!(/[^0-9A-Za-z]/, ' ')
    contain.downcase!
    return contain.split
  end

  def tags(arr, id)
    booking  = ['reserver', 'reserve', 'book', 'rendez', 'appointement', 'reservation', 'booking', 'couper', 'cut', 'coupe', 'booker']
    hours = ['heure', 'hour', 'hours', 'ouverture', 'opening', 'time', 'close', 'fermeture', 'fermer', 'ferme', 'fermez', 'closing', 'open', 'horaire', "lhoraire"]
    address = ['adresse', 'emplacement', 'location', 'address', 'where', 'ou']

    # Location TAG ---------
    if (arr & ["vieux", "old", "port"]).present?
      Status.where(:sender => id).update(location: "vieuxMontreal")
    elsif arr.include?('marie')
      Status.where(:sender => id).update(location: "villeMarie")
    elsif arr.include?('mile')
      Status.where(:sender => id).update(location: "mileEnd")
    elsif arr.include?('dix30') or arr.include?('quartier') or arr.include?('DIX30')
      Status.where(:sender => id).update(location: "quartier")
    elsif arr.include?('rudsak')
      Status.where(:sender => id).update(location: "rudsak")
    elsif arr.include?('academy')
      Status.where(:sender => id).update(location: "academy")
    end

    # Intent TAG
    if (arr & booking).empty? == false
      Status.where(:sender => id).update(intent: "booking")
    elsif (arr & hours).empty? == false
      Status.where(:sender => id).update(intent: "opening")
    elsif (arr & address).empty? == false
      Status.where(:sender => id).update(intent: "location")
    end

  end

  def timediff(id, diff)
    if ((Time.now - Status.find_by(sender: id).updated_at) / 60) < diff
      return false
    else
      return true
    end
  end

  def greeting(arr, id)
    greetings = ['salut', 'bonjour', 'bonsoir', 'hello', 'hi', 'hey']

    if (arr & greetings).empty? == false
      Status.where(:sender => id).update(status: "greetings")
    else
      Status.where(:sender => id).update(status: "conversation")
    end
  end



end
