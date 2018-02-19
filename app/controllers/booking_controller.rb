class BookingController < ApplicationController
require "facebook/messenger"
include Facebook::Messenger

  def location(id)
    Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
    Bot.deliver({
      recipient: {
        id: id
      },
      message: {
        text: 'All right! You need to first chose a location:',
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
            title: 'Academy (Pointe Saint-Charles)',
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
end
