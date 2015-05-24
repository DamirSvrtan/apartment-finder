class ApartmentScrapper

  def self.scrape(urls = [])
    urls.each { |url| new(url).scrape }
  end

  def initialize(url)
    @url = url
  end

  def apartment_elements
    @apartment_elements ||= regular_apartment_elements + vauvau_apartment_elements
  end

  private

  attr_reader :url

  def response_body
    @response_body ||= HTTParty.get(url)
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

  # def apartments
  #   @apartments ||= apartment_elements.map {|apartment_element| Apartment.new(apartment_element)}
  # end
end
