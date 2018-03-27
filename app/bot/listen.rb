require "facebook/messenger"
include Facebook::Messenger

$mapping = { :vieuxMontreal => "Vieux-Montréal",
              :villeMarie => "Place Ville-Marie",
              :mileEnd => "Mile-End",
              :quartier => "Quartier DIX30",
              :rudsak => "Rudsak",
              :academy => "Academy"
  }
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  id = message.sender["id"]
  first_name = BookingController.new.name(id)[0]

  cleanArray = TextController.new.cleanString(message.text)
  TextController.new.tags(cleanArray, id) #create tags

    if Status.where(:sender => id).exists?
      user = Status.where(:sender => id)
    else
      Status.new(status: "enrollement", sender: id, language: "notDefine", count: 0).save
    end

    if message.text == 'English' #defining language
      user.update(status: "defineLanguage", language: "English")
    elsif message.text == 'Français'
      user.update(status: "defineLanguage", language: "Français")
    end

    start = TextController.new.timediff(id, 5)
    language = CLD.detect_language(message.text)['name'.to_sym].capitalize
    status = Status.find_by(sender: id).status
    location = Status.find_by(sender: id).location
    intent = Status.find_by(sender: id).intent
    count = Status.find_by(sender: id).count

      BookingController.new.introduction(id, first_name, language, count) if count == 0

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

      # Intent = booking, location and start -----
      elsif location != "" and intent == "booking"
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true
          if language == 'English'
            BookingController.new.tempLink(id, location, language, 'There you go 💈💺!')
          else
            BookingController.new.tempLink(id, location, 'French', 'Voilà 💈💺!')
          end

          Status.where(:sender => id).update(location: "")
          Status.where(:sender => id).update(intent: "")
          Status.where(:sender => id).update(count: count + 1)

      # Intent = opening, location and start -----
      elsif location != "" and intent == "opening"
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true
          BookingController.new.schedule(id, location, language)

          Status.where(:sender => id).update(location: "")
          Status.where(:sender => id).update(intent: "")
          Status.where(:sender => id).update(count: count + 1)

      # lntent = location, location and start -----
      elsif location != "" and intent == "location"
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true
          if language == 'English'
            BookingController.new.address(id, location, language, 'There you go 💈!')
          else
            BookingController.new.address(id, location, language, 'Voilà 💈!')
          end

          Status.where(:sender => id).update(location: "")
          Status.where(:sender => id).update(intent: "")
          Status.where(:sender => id).update(count: count + 1)

      # No intent, location and start -----
      elsif intent == "" and location != ""
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true
          BookingController.new.intent(id, location, language)

      # Intent, no location ---------------
      elsif intent != "" and location == ""
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true
          BookingController.new.location(id, "For which location?")

      elsif count > 0

        if language == 'English'

            BookingController.new.prensation(id, first_name, language) if start == true
            message.reply(
            text: "I've been trained to help you with the options listed below!",
            quick_replies: [
              {
                content_type: 'text',
                title: 'Book a chair!',
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: 'Opening hours',
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: 'Find an address',
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: 'Ask a question',
                payload: 'HARMLESS'
              }
            ])

        elsif language == 'French'

          BookingController.new.prensation(id, first_name, language) if start == true
          message.reply(
            text: "J'ai été entrainé pour t'aider avec les options ci-dessous!",
            quick_replies: [
              {
                content_type: 'text',
                title: 'Réserver une chaise',
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: "Heure d'ouverture",
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: 'Trouver une adresse',
                payload: 'HARMLESS'
              },
              {
                content_type: 'text',
                title: 'Poser une question',
                payload: 'HARMLESS'
              }
            ])

        else

          message.reply(
            text: "Sorry, I don't speak #{language.capitalize}")

        end

      end

end







