require 'bundler'
Bundler.setup

require 'pry'
require 'mongo_mapper'
require 'json/ext'
require 'faraday'
require 'oga'

require_relative 'mongo_setup'
require_relative 'apartment'
require_relative 'scraped_apartment'
require_relative 'apartment_scrapper'

TRESNJEVKA_SJEVER = 'http://www.njuskalo.hr/?ctl=browse_ads&sort=new&categoryId=10920&locationId=2814&locationId_level_0=1153&locationId_level_1=1262&locationId_level_2=2814&priceLimitFrom=159&priceLimitTo=350&mainAreaFrom=&mainAreaTo=&adsWithImages=1&flatTypeId=0&floorCountId=0&roomCountId=0&flatFloorIdFrom=0&flatFloorIdTo=0&gardenAreaFrom=&gardenAreaTo=&balconyAreaFrom=&balconyAreaTo=&teraceAreaFrom=&teraceAreaTo=&yearBuiltFrom=&yearBuiltTo=&yearLastRebuildFrom=&yearLastRebuildTo='

ApartmentScrapper.scrape([
  TRESNJEVKA_SJEVER
])
