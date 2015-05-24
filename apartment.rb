class Apartment
  include MongoMapper::Document

  key :name, String
  key :njuskalo_id, Integer
  key :link, String
end
