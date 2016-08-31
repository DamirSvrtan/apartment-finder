require 'bundler'

Bundler.setup
Encoding.default_external = Encoding::UTF_8

require 'pry'
require 'mongo_mapper'
require 'json/ext'
require 'httparty'
require 'oga'
require 'action_mailer'

require_relative 'mongo_setup'
require_relative 'action_mailer_setup'
require_relative 'apartment'
require_relative 'apartment_parser'
require_relative 'apartment_scrapper'
require_relative 'new_apartment_mailer'
require_relative 'new_apartment_saver'

MySettings = OpenStruct.new
MySettings.recipients = %w(damir.svrtan@gmail.com jelena.skracic@gmail.com)

TRESNJEVKA_SJEVER_URL = 'http://www.njuskalo.hr/?ctl=browse_ads&sort=new&categoryId=10920&locationId=2814&locationId_level_0=1153&locationId_level_1=1262&locationId_level_2=2814&priceLimitFrom=150&priceLimitTo=400&mainAreaFrom=34&mainAreaTo=65&adsWithImages=1&flatTypeId=0&floorCountId=0&roomCountId=0&flatFloorIdFrom=195&flatFloorIdTo=0&gardenAreaFrom=&gardenAreaTo=&balconyAreaFrom=&balconyAreaTo=&teraceAreaFrom=&teraceAreaTo=&yearBuiltFrom=&yearBuiltTo=&yearLastRebuildFrom=&yearLastRebuildTo='
CRNOMEREC_URL = 'http://www.njuskalo.hr/?ctl=browse_ads&sort=new&categoryId=10920&locationId=2597&locationId_level_0=1153&locationId_level_1=1248&locationId_level_2=2597&priceLimitFrom=159&priceLimitTo=400&mainAreaFrom=40&mainAreaTo=&adsWithImages=1&flatTypeId=0&floorCountId=0&roomCountId=0&flatFloorIdFrom=195&flatFloorIdTo=0&gardenAreaFrom=&gardenAreaTo=&balconyAreaFrom=&balconyAreaTo=&teraceAreaFrom=&teraceAreaTo=&yearBuiltFrom=&yearBuiltTo=&yearLastRebuildFrom=&yearLastRebuildTo='

areas = [
  {
    name: 'Tresnjevka sjever',
    url: TRESNJEVKA_SJEVER_URL
  },
  {
    name: 'Crnomerec',
    url: CRNOMEREC_URL
  }
]

areas.each do |area|
  begin
    NewApartmentSaver.new(url: area[:url], area: area[:name]).call
  rescue => error
    Logger.new('njuskalo-cron-errors.log').error(error)
  end
end

# scrapper = ApartmentScrapper.new(TRESNJEVKA_SJEVER_URL)
# parser = ApartmentParser.new(scrapper.apartment_elements.first)
# binding.pry
