require "facebook/messenger"
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  id = message.sender["id"]

  if Status.where(:sender => id).exists?

    if message.text == 'English' #defining language
      Status.new(status: "defineLanguage", sender: id, language: message.text).save
    elsif message.text == 'Français'
      Status.new(status: "defineLanguage", sender: id, language: message.text).save
    end

    puts language = Status.where(:sender => id).last.language
    puts status = Status.where(:sender => id).last.status

    if language == 'English' # -------------------------------------------

      if status == 'question'
        message.typing_on
        Status.new(status: "questionDelivered", sender: id, language: 'English').save
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
        Status.new(status: "hours", sender: id, language: 'English').save
        BookingController.new.location(id, "What location are you looking for?")

      elsif status == 'hours'
        message.typing_on
        puts "hello"
        case message.text

        when /Vieux-Montréal/i
          Status.new(status: "openingVieux", sender: id, language: 'English').save
          BookingController.new.schedule(id, "vieux", 'English')

        when /Place Ville-Marie/i
          Status.new(status: "openingVilleMarie", sender: id, language: 'English').save
          BookingController.new.schedule(id, "villeMarie", 'English')

        when /Quartier DIX30/i
          Status.new(status: "openingQuartier", sender: id, language: 'English').save
          BookingController.new.schedule(id, "quartier", 'English')

        when /Mile-End/i
          Status.new(status: "openingMileEnd", sender: id, language: 'English').save
          BookingController.new.schedule(id, "mileEnd", 'English')

        when "Rudsak (Ahuntsic)"
          Status.new(status: "openingRudsak", sender: id, language: 'English').save
          BookingController.new.schedule(id, "rudsak", 'English')

        when "Academy"
          Status.new(status: "openingAcademy", sender: id, language: 'English').save
          BookingController.new.schedule(id, "academy", 'English')
        end

      else
        message.typing_on
        case message.text #first degree response

        when /Ask a question!/i
          Status.new(status: "question", sender: id, language: 'English').save
          message.reply(
            text: 'You may ask whatever you want, a human will respond as soon as possible'
          )

        when /Book a haircut!/i
          Status.new(status: "book", sender: id, language: 'English').save
          BookingController.new.location(id, "All right! You need to first chose a location:")

        when /Vieux-Montréal/i
          Status.new(status: "vieuxMontreal", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'vieux', 'English', 'There you go!')

        when /Place Ville-Marie/i
          Status.new(status: "villeMarie", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'villeMarie', 'English', 'There you go!')

        when /Quartier DIX30/i
          Status.new(status: "quartier", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'quartier', 'English', 'There you go!')

        when /Mile-End/i
          Status.new(status: "mileEnd", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'mileEnd', 'English', 'There you go!')

        when "Rudsak (Ahuntsic)"
          Status.new(status: "rudsak", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'rudsak', 'English', 'There you go!')

        when "Academy"
          Status.new(status: "academy", sender: id, language: 'English').save
          BookingController.new.tempLink(id, 'academy', 'English', 'There you go!')

        when /Opening hours?/i
          Status.new(status: "hours", sender: id, language: 'English').save
          BookingController.new.location(id, "What location are you looking for?")


        else #main menu
          message.reply(
          text: 'Hello, what are you looking for?',
          quick_replies: [
            {
              content_type: 'text',
              title: 'Book a haircut!',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Opening hours?',
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
        Status.new(status: "questionDelivered", sender: id, language: 'Français').save
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
        Status.new(status: "hours", sender: id, language: 'Français').save
        BookingController.new.location(id, "Quelle emplacement recherches tu?")

      elsif status == 'hours'
        message.typing_on
        puts "hello"
        case message.text

        when /Vieux-Montréal/i
          Status.new(status: "openingVieux", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "vieux", 'Français')

        when /Place Ville-Marie/i
          Status.new(status: "openingVilleMarie", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "villeMarie", 'Français')

        when /Quartier DIX30/i
          Status.new(status: "openingQuartier", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "quartier", 'Français')

        when /Mile-End/i
          Status.new(status: "openingMileEnd", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "mileEnd", 'Français')

        when "Rudsak (Ahuntsic)"
          Status.new(status: "openingRudsak", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "rudsak", 'Français')

        when "Academy"
          Status.new(status: "openingAcademy", sender: id, language: 'Français').save
          BookingController.new.schedule(id, "academy", 'Français')
        end

      else
        message.typing_on
        case message.text #first degree response

        when /Pauser une question!/i
          Status.new(status: "question", sender: id, language: 'Français').save
          message.reply(
            text: 'Pauses ta question, un humain te répondra dès que possible'
          )

        when /Rendez-vous!/i
          Status.new(status: "book", sender: id, language: 'Français').save
          BookingController.new.location(id, "Parfait! Tu dois choisir un emplacement:")

        when /Vieux-Montréal/i
          Status.new(status: "vieuxMontreal", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'vieux', 'Français', 'Voilà!')

        when /Place Ville-Marie/i
          Status.new(status: "villeMarie", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'villeMarie', 'Français', 'Voilà!')

        when /Quartier DIX30/i
          Status.new(status: "quartier", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'quartier', 'Français', 'Voilà!')

        when /Mile-End/i
          Status.new(status: "mileEnd", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'mileEnd', 'Français', 'Voilà!')

        when "Rudsak (Ahuntsic)"
          Status.new(status: "rudsak", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'rudsak', 'Français', 'Voilà!')

        when "Academy"
          Status.new(status: "academy", sender: id, language: 'Français').save
          BookingController.new.tempLink(id, 'academy', 'Français', 'Voilà!')

        when /Heure d'ouverture?/i
          Status.new(status: "hours", sender: id, language: 'Français').save
          BookingController.new.location(id, "Pour quel emplacement?")


        else #main menu
          message.reply(
          text: "Salut, qu'est ce que tu recherches?",
          quick_replies: [
            {
              content_type: 'text',
              title: 'Rendez-vous!',
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: "Heure d'ouverture?",
              payload: 'HARMLESS'
            },
            {
              content_type: 'text',
              title: 'Pauser une question!',
              payload: 'HARMLESS'
            }
          ]
          )

        end

      end

    end

  else #language menu ----------------------------------------------------
    Status.new(status: "enrollement", sender: id).save
    message.reply(
        text: 'Welcome to Maison Privée',
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







