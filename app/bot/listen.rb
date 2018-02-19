require "facebook/messenger"
include Facebook::Messenger


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|
  id = message.sender["id"]
  status = ''

  if Status.where(:sender => id).exists?
    status = Status.where(:sender => id).last.status
  end

  p status

  if status == 'question'
    Status.new(status: "questionDelivered", sender: id).save
    Bot.deliver({
      recipient: {
        id: id
      },
      message: {
        text: message.text
      }
    }, access_token: ENV['ACCESS_TOKEN'])
  else
    message.typing_on
    case message.text

    when /Ask a question!/i
      Status.new(status: "question", sender: id).save
      message.reply(
        text: 'You may ask whatever you want, a human will respond as soon as possible'
      )

    when /Book a haircut!/i
      Status.new(status: "book", sender: id).save
      BookingController.new.location(id)

    when /Vieux-Montréal/i
      Status.new(status: "vieuxMontreal", sender: id).save
      BookingController.new.service(id)

    when /Place Ville-Marie/i
      Status.new(status: "villeMarie", sender: id).save
      BookingController.new.service(id)

    when /Quartier DIX30/i
      Status.new(status: "quartier", sender: id).save
      BookingController.new.service(id)

    when /Mile-End/i
      Status.new(status: "mileEnd", sender: id).save
      BookingController.new.service(id)

    when /Rudsak (Ahuntsic)/i
      Status.new(status: "rudsak", sender: id).save
      BookingController.new.service(id)

    when /Academy (Pointe Saint-Charles)/i
      Status.new(status: "academy", sender: id).save
      BookingController.new.service(id)

    else
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
          title: 'Ask a question!',
          payload: 'HARMLESS'
        }
      ]
      )
    end
  end


end







