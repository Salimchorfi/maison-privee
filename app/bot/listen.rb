require "facebook/messenger"
include Facebook::Messenger

$mapping = {  :vieuxMontreal => "Vieux-Montréal",
              :villeMarie => "Place Ville-Marie",
              :mileEnd => "Mile-End",
              :quartier => "Quartier DIX30",
              :rudsak => "Rudsak",
              :academy => "Academy",
              :saintHyacinthe => "Saint-Hyacinthe"
            }

# Facebook::Messenger::Profile.set({
#   greeting: [
#     {
#       locale: 'default',
#       text: 'Welcome to Maison privée 🏠💈'
#     },
#     {
#       locale: 'fr_FR',
#       text: 'Bienvenue chez Maison Privée 🏠💈'
#     }
#   ]

#   get_started: {
#     payload: 'GET_STARTED_PAYLOAD'
#   }
# }, access_token: ENV['ACCESS_TOKEN'])

Facebook::Messenger::Profile.set({
  get_started: {
    payload: 'GET_STARTED_PAYLOAD'
  }
}, access_token: ENV['ACCESS_TOKEN'])

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  puts message.text #helps for debug
  id = message.sender["id"]
  first_name = BookingController.new.name(id)[0]

  cleanArray = TextController.new.cleanString(message.text)
  TextController.new.tags(cleanArray, id) #create tags
  TextController.new.greeting(cleanArray, id) #create status

    if Status.where(:sender => id).exists?
      user = Status.where(:sender => id)
    else
      Status.new(status: "enrollement", sender: id, language: "notDefine", count: 0).save
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

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
          if language == 'English'
            BookingController.new.tempLink(id, location, language, 'There you go 💈💺!')
          else
            BookingController.new.tempLink(id, location, 'French', 'Voilà 💈💺!')
          end

          Status.where(:sender => id).update(location: "")
          Status.where(:sender => id).update(intent: "")
          Status.where(:sender => id).update(count: count + 1)

          BookingController.new.updateLog(id, location)

      # Intent = opening, location and start -----
      elsif location != "" and intent == "opening"
        message.typing_on

          language = 'English' if message.text == 'Opening hours'

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
          BookingController.new.schedule(id, location, language)

          Status.where(:sender => id).update(location: "")
          Status.where(:sender => id).update(intent: "")
          Status.where(:sender => id).update(count: count + 1)

      # lntent = location, location and start -----
      elsif location != "" and intent == "location"
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
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

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
          BookingController.new.intent(id, location, language)

      # Intent, no location ---------------
      elsif intent != "" and location == ""
        message.typing_on

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
          if language == 'English'
            BookingController.new.location(id, "For which location?")
          else
            BookingController.new.location(id, "Pour quel emplacement?")
          end

      elsif count > 0

        if language == 'English'

            BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
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

        elsif language == 'French' or status == "greetings"

          BookingController.new.prensation(id, first_name, language) if start == true or status == "greetings"
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







