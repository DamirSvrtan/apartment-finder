class NewApartmentSaver

  def initialize(url:, area:)
    @scrapper = ApartmentScrapper.new(url)
    @area = area
  end

  def call
    new_apartments.each do |new_apartment|
      new_apartment.save!

      return if new_apartments.count == apartments.count # initialization

      puts 1

      NewApartmentMailer.sendout(
        apartment: new_apartment,
        recipients: MySettings.recipients,
        area: @area
      ).deliver_now
    end
  end

  def apartments
    @apartments ||= @scrapper.apartment_elements.map do |apartment_element|
      apartment_parser = ApartmentParser.new(apartment_element)
      apartment = Apartment.find_or_initialize_by_njuskalo_id(apartment_parser.njuskalo_id)

      unless apartment.persisted?
        apartment.name = apartment_parser.name
        apartment.link = apartment_parser.link
      end

      apartment
    end
  end

  def new_apartments
    @new_apartments ||= apartments.reject(&:persisted?)
  end

end
