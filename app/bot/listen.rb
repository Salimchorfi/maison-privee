require "facebook/messenger"
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  id = message.sender["id"]

  if Status.where(:sender => id).exists?
    user = Status.where(:sender => id)

    if message.text == 'English' #defining language
      user.update(status: "defineLanguage", language: "English")
    elsif message.text == 'Français'
      user.update(status: "defineLanguage", language: "Français")
    end

    language = Status.where(:sender => id).language
    status = Status.where(:sender => id).status

    if language == 'English' # -------------------------------------------

      if status == 'question'
        message.typing_on
        user.update(status: "questionDelivered", language: "English")
        Bot.deliver({
          recipient: {
            id: id #to be validated
          },
          message: {
            text: message.text
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif status == 'opening'
        message.typing_on
        user.update(status: "hours", language: "English")
        BookingController.new.location(id, "For which location?")

      elsif status == 'hours'
        message.typing_on
        case message.text

        when /Vieux-Montréal/i
          user.update(status: "openingVieux", language: "English")
          BookingController.new.schedule(id, "vieux", 'English')

        when /Place Ville-Marie/i
          user.update(status: "openingVilleMarie", language: "English")
          BookingController.new.schedule(id, "villeMarie", 'English')

        when /Quartier DIX30/i
          user.update(status: "openingQuartier", language: "English")
          BookingController.new.schedule(id, "quartier", 'English')

        when /Mile-End/i
          user.update(status: "openingMileEnd", language: "English")
          BookingController.new.schedule(id, "mileEnd", 'English')

        when "Rudsak (Ahuntsic)"
          user.update(status: "openingRudsak", language: "English")
          BookingController.new.schedule(id, "rudsak", 'English')

        when "Academy"
          user.update(status: "openingAcademy", language: "English")
          BookingController.new.schedule(id, "academy", 'English')
        end

      elsif status == 'address'
        message.typing_on
        case message.text

        when /Vieux-Montréal/i
          user.update(status: "openingVieux", language: "English")
          BookingController.new.address(id, "vieux")

        when /Place Ville-Marie/i
          user.update(status: "openingVilleMarie", language: "English")
          BookingController.new.address(id, "villeMarie")

        when /Quartier DIX30/i
          user.update(status: "openingQuartier", language: "English")
          BookingController.new.address(id, "quartier")

        when /Mile-End/i
          user.update(status: "openingMileEnd", language: "English")
          BookingController.new.address(id, "mileEnd")

        when "Rudsak (Ahuntsic)"
          user.update(status: "openingRudsak", language: "English")
          BookingController.new.address(id, "rudsak")

        when "Academy"
          user.update(status: "openingAcademy", language: "English")
          BookingController.new.address(id, "academy")
        end

      else
        message.typing_on
        case message.text #first degree response

        when /Ask a question!/i
          user.update(status: "question", language: "English")
          message.reply(
            text: "You may ask whatever you want, we'll get back to you as soon as possible"
          )

        when /Make a reservation!/i
          user.update(status: "book", language: "English")
          BookingController.new.location(id, "All right! You need to first chose a location:")

        when /Find an address/i
          user.update(status: "address", language: "English")
          BookingController.new.location(id, "For which location?")

        when /Vieux-Montréal/i
          user.update(status: "vieuxMontreal", language: "English")
          BookingController.new.tempLink(id, 'vieux', 'English', 'There you go!')

        when /Place Ville-Marie/i
          user.update(status: "villeMarie", language: "English")
          BookingController.new.tempLink(id, 'villeMarie', 'English', 'There you go!')

        when /Quartier DIX30/i
          user.update(status: "quartier", language: "English")
          BookingController.new.tempLink(id, 'quartier', 'English', 'There you go!')

        when /Mile-End/i
          user.update(status: "mileEnd", language: "English")
          BookingController.new.tempLink(id, 'mileEnd', 'English', 'There you go!')

        when "Rudsak (Ahuntsic)"
          user.update(status: "rudsak", language: "English")
          BookingController.new.tempLink(id, 'rudsak', 'English', 'There you go!')

        when "Academy"
          user.update(status: "academy", language: "English")
          BookingController.new.tempLink(id, 'academy', 'English', 'There you go!')

        when /Opening hours?/i
          user.update(status: "hours", language: "English")
          BookingController.new.location(id, "What location are you looking for?")


        else #main menu
          message.reply(
          text: 'Hello, what are you looking for?',
          quick_replies: [
            {
              content_type: 'text',
              title: 'Make a reservation!',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Opening hours?',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Find an address',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Ask a question!',
              payload: 'HARMLESS'
            }
          ]
          )

        end

      end

    else #french ---------------------------------------------------------

      if status == 'question'
        message.typing_on
        user.update(status: "questionDelivered", language: "Français")
        Bot.deliver({
          recipient: {
            id: id #to be validated
          },
          message: {
            text: message.text
          }
        }, access_token: ENV['ACCESS_TOKEN'])

      elsif status == 'opening'
        message.typing_on
        user.update(status: "hours", language: "Français")
        BookingController.new.location(id, "Pour quel emplacement?")

      elsif status == 'hours'
        message.typing_on
        case message.text

        when /Vieux-Montréal/i
          user.update(status: "openingVieux", language: "Français")
          BookingController.new.schedule(id, "vieux", 'Français')

        when /Place Ville-Marie/i
          user.update(status: "openingVilleMarie", language: "Français")
          BookingController.new.schedule(id, "villeMarie", 'Français')

        when /Quartier DIX30/i
          user.update(status: "openingQuartier", language: "Français")
          BookingController.new.schedule(id, "quartier", 'Français')

        when /Mile-End/i
          user.update(status: "openingMileEnd", language: "Français")
          BookingController.new.schedule(id, "mileEnd", 'Français')

        when "Rudsak (Ahuntsic)"
          user.update(status: "openingRudsak", language: "Français")
          BookingController.new.schedule(id, "rudsak", 'Français')

        when "Academy"
          user.update(status: "openingAcademy", language: "Français")
          BookingController.new.schedule(id, "academy", 'Français')
        end

      elsif status == 'address'
        message.typing_on
        case message.text

        when /Vieux-Montréal/i
          user.update(status: "openingVieux", language: "Français")
          BookingController.new.address(id, "vieux")

        when /Place Ville-Marie/i
          user.update(status: "openingVilleMarie", language: "Français")
          BookingController.new.address(id, "villeMarie")

        when /Quartier DIX30/i
          user.update(status: "openingQuartier", language: "Français")
          BookingController.new.address(id, "quartier")

        when /Mile-End/i
          user.update(status: "openingMileEnd", language: "Français")
          BookingController.new.address(id, "mileEnd")

        when "Rudsak (Ahuntsic)"
          user.update(status: "openingRudsak", language: "Français")
          BookingController.new.address(id, "rudsak")

        when "Academy"
          user.update(status: "openingAcademy", language: "Français")
          BookingController.new.address(id, "academy")
        end

      else
        message.typing_on
        case message.text #first degree response

        when /Poser une question!/i
          user.update(status: "question", language: "Français")
          message.reply(
            text: 'Poses ta question, nous te reviendrons dès que possible'
          )

        when /Réserver une chaise!/i
          user.update(status: "book", language: "Français")
          BookingController.new.location(id, "Parfait! Tu dois choisir un emplacement:")

        when /Trouver une adresse/i
          user.update(status: "address", language: "Français")
          BookingController.new.location(id, "Pour quel emplacement?")

        when /Vieux-Montréal/i
          user.update(status: "vieuxMontreal", language: "Français")
          BookingController.new.tempLink(id, 'vieux', 'Français', 'Voilà!')

        when /Place Ville-Marie/i
          user.update(status: "villeMarie", language: "Français")
          BookingController.new.tempLink(id, 'villeMarie', 'Français', 'Voilà!')

        when /Quartier DIX30/i
          user.update(status: "quartier", language: "Français")
          BookingController.new.tempLink(id, 'quartier', 'Français', 'Voilà!')

        when /Mile-End/i
          user.update(status: "mileEnd", language: "Français")
          BookingController.new.tempLink(id, 'mileEnd', 'Français', 'Voilà!')

        when "Rudsak (Ahuntsic)"
          user.update(status: "rudsak", language: "Français")
          BookingController.new.tempLink(id, 'rudsak', 'Français', 'Voilà!')

        when "Academy"
          user.update(status: "academy", language: "Français")
          BookingController.new.tempLink(id, 'academy', 'Français', 'Voilà!')

        when /Heure d'ouverture?/i
          user.update(status: "hours", language: "Français")
          BookingController.new.location(id, "Pour quel emplacement?")


        else #main menu
          message.reply(
          text: "Salut, qu'est ce que tu recherches?",
          quick_replies: [
            {
              content_type: 'text',
              title: 'Réserver une chaise 💺',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: "Heure d'ouverture 🕓",
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Trouver une adresse 🌎',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Poser une question 🆘',
              payload: 'HARMLESS'
            }
          ]
          )

        end

      end

    end

  else #language menu ----------------------------------------------------
    Status.new(status: "enrollement", sender: id, language: "notDefine").save
    message.reply(
        text: 'Welcome to Maison Privée 🏠💈',
        quick_replies: [
          {
            content_type: 'text',
            title: 'Français',
            payload: 'HARMLESS'
          },
          {
            content_type: 'text',
            title: 'English',
            payload: 'HARMLESS'
          }
        ]
      )
  end

end







