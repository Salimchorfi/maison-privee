namespace :db do

  desc "Crypto currencies bot"

  task :fillForm => :environment do

    require 'mechanize'
    require 'nokogiri'
    require 'open-uri'

    artists = []
    locations = []
    addresses = []

    pageArtist = Nokogiri::HTML(open("http://www.maisonprivee.ca/en/artists"))
    pageLocation = Nokogiri::HTML(open("http://www.maisonprivee.ca/en/locations"))

    pageLocation.css('div.booking__info').each do |location|
      locations << [location.css('div.booking__title').text, location.css('div.booking__text').text]
    end

    pageArtist.css('div.artist__name').each do |artist|
      artists << artist.text
    end

    artists.uniq!
    locations.uniq!

    locations.each do |location|
      Location.new(name: location[0].strip, address: location[1].strip).save
    end

    artists.each do |artist|
      artist[0] = artist[0].downcase

      puts artist.strip.gsub(" ", "-")

      #puts "http://www.maisonprivee.ca/artists/#{artist.strip.gsub(" ", "-")}"
      #page = Nokogiri::HTML(open("http://www.maisonprivee.ca/artists/#{artist.strip.gsub(" ", "-")}"))
      #location = page.css('div.list-info__item a')[1].text

      #Artist.new(name: artist.strip, location: location.strip)
    end







  end

end
