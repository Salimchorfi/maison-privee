class BookingController < ApplicationController
require "facebook/messenger"
require 'nokogiri'
require 'open-uri'
require 'json'
include Facebook::Messenger

  def name(id)
    url = "https://graph.facebook.com/v2.6/#{id}?fields=first_name,last_name,profile_pic&access_token=#{ENV["ACCESS_TOKEN"]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    return [user["first_name"], user["last_name"]]
  end

  def location(id, text)
    Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
    Bot.deliver({
      recipient: {
        id: id
      },
      message: {
        text: text,
        quick_replies: [
          {
            content_type: 'text',
            title: 'Vieux-Montréal',
            payload: 'Vieux'
          },
          {
            content_type: 'text',
            title: 'Place Ville-Marie',
            payload: 'Ville-Marie'
          },
          {
            content_type: 'text',
            title: 'Quartier DIX30',
            payload: 'Quartier'
          },
          {
            content_type: 'text',
            title: 'Mile-End',
            payload: 'Mile-End'
          },
          {
            content_type: 'text',
            title: 'Rudsak (Ahuntsic)',
            payload: 'Rudsak'
          },
          {
            content_type: 'text',
            title: 'Academy',
            payload: 'Academy'
          }
        ]
      }
    }, access_token: ENV['ACCESS_TOKEN'])
  end

  def service(id)
    Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
    Bot.deliver({
      recipient: {
        id: id
      },
      message: {
        text: 'What service are you looking for?',
        quick_replies: [
          {
            content_type: 'text',
            title: 'Haircut',
            payload: 'Haircut'
          },
          {
            content_type: 'text',
            title: 'Lineup',
            payload: 'Lineup'
          },
          {
            content_type: 'text',
            title: 'Shave',
            payload: 'Shave'
          },
          {
            content_type: 'text',
            title: 'Haircut Lineup',
            payload: 'HaircutLineup'
          },
          {
            content_type: 'text',
            title: 'Kids Haircut',
            payload: 'KidsHaircut'
          },
          {
            content_type: 'text',
            title: 'Full Set',
            payload: 'FullSet'
          }
        ]
      }
    }, access_token: ENV['ACCESS_TOKEN'])
  end

  def tempLink(id, location, language, text)
    case location

    when /vieux/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: text,
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://maisonprivee.appointy.com/default.aspx?_ga=1.219348953.1993957800.1476457930",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /villeMarie/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: text,
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://maisonpriveepvm.appointy.com/default.aspx",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /quartier/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: text,
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://maisonpriveedix30.appointy.com/default.aspx",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /mileEnd/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: text,
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://maisonpriveemileend.appointy.com/default.aspx",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /rudsak/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: text,
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://maisonpriveerudsak.appointy.com",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /academy/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Please take notes that this location is an academy. Some of  the barbers you'll see online are Students and cut at a discounted price.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "We have a professional barbers in shop (Xander Sharp) cutting at regular price. You can find him on the booking link below.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: text,
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Veuillez noter que ce lieu est une académie. Certains des coiffeurs que vous verrez en ligne sont étudiants et coupés à un prix réduit.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Nous avons un salon de coiffure professionnel (Xander Sharp) à prix régulier. Vous pouvez le trouver sur le lien de réservation ci-dessous",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: text,
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

      Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "https://maisonpriveeacademy.appointy.com",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

    end
  end

  def schedule(id, location, language)
    case location

    when /vieux/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Tuesday/Wednesday: 11:00 AM - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Thursday/Friday: 11:00 AM - 9:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Saturday: 11:00 AM - 5:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Mardi/Mercredi: 11:00 AM - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Jeudi/Vendredi: 11:00 AM - 9:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Samedi: 11:00 AM - 5:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

    when /villeMarie/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Monday to Friday: 10:00 am - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Lundi à Vendredi: 10:00 am - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

    when /quartier/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Tuesday/Wednesday: 11:00 AM - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Thursday/Friday: 11:00 AM - 9:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Saturday/Sunday: 11:00 AM - 5:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Mardi/Mercredi: 11:00 AM - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Jeudi/Vendredi: 11:00 AM - 9:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Samedi/Dimanche: 11:00 AM - 5:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

    when /mileEnd/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Tuesday/Wednesday: 11:00 AM - 7:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Thursday/Friday: 11:00 AM - 9:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Saturday: 11:00 AM - 5:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "Mardi/Mercredi: 11:00 AM - 7:00 PM 🕓",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "Jeudi/Vendredi: 11:00 AM - 9:00 PM 🕓",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "Samedi: 11:00 AM - 5:00 PM 🕓",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

    end

    when /rudsak/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Tuesday to Saturday: 10:00 AM - 6:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Mardi à Samedi: 10:00 AM - 6:00 PM 🕓",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

    when /academy/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      if language == 'English'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Please take notes that this location is an academy. Some of  the barbers you'll see online are Students and cut at a discounted price.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "We have a professional barbers in shop (Xander Sharp) cutting at regular price. You can find him on the booking link below.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif language == 'Français'

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Veuillez noter que ce lieu est une académie. Certains des coiffeurs que vous verrez en ligne sont étudiants et coupés à un prix réduit.",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "Nous avons un salon de coiffure professionnel (Xander Sharp) à prix régulier. Vous pouvez le trouver sur le lien de réservation ci-dessous",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end

    end

  end

  def address(id, location)

    case location

    when /vieux/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://goo.gl/maps/uPFyeQ3FziD2 🌎",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /villeMarie/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://goo.gl/maps/NyTGC1ENzGt 🌎",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /quartier/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://goo.gl/maps/QZgedKbcvzt 🌎",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /mileEnd/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://goo.gl/maps/Lce9UWgHu4x 🌎",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /rudsak/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
      Bot.deliver({
        recipient: {
          id: id
        },
        message: {
          text: "https://goo.gl/maps/kDevaapuBaw 🌎",
        }
      }, access_token: ENV['ACCESS_TOKEN'])

      when /academy/i
      Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

        Bot.deliver({
          recipient: {
            id: id
          },
          message: {
            text: "https://goo.gl/maps/EskX8ewRn9w 🌎",
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      end
  end
end
