class ApartmentScrapper

  def self.scrape(urls = [])
    urls.each { |url| new(url).scrape }
  end

  def initialize(url)
    @url = url
  end

  def scrape
    binding.pry
    # parsed_apartments.each do |parsed_apartment|
    #   if Apartment.where(parsed_apartment.id).first.nil?
    #     new_apartment = Apartment.new(attributes)
    #     new_apartment.save
    #     send_email
    #   end
    # end
  end

  private

  attr_reader :url

  def response_body
    @response_body ||= request.get.body
  end

  def response_document
    @response_document ||= Oga.parse_html(response_body)
  end

  def regular_apartment_elements
    @regular_apartment_elements ||= response_document.xpath('//div[contains(@class, "content-main")]/div[contains(@class, "block-standard")]/div[contains(@class, "EntityList--Regular")]/ul[contains(@class, "EntityList-items")]/li[contains(@class, "EntityList-item--Regular")]')
  end

  def vauvau_apartment_elements
    @vauvau_apartment_elements ||= response_document.xpath('//div[contains(@class, "content-main")]/div[contains(@class, "block-standard")]/div[contains(@class, "EntityList--VauVau")]/ul[contains(@class, "EntityList-items")]/li[contains(@class, "EntityList-item--VauVau")]')
  end

  def apartment_elements
    @apartment_elements ||= regular_apartment_elements + vauvau_apartment_elements
  end

  def apartments
    @apartments ||= apartment_elements.map {|apartment_element| ScrapedApartment.new(apartment_element)}
  end

  def request
    Faraday.new(url: url)
  end
end
