class ScrapedApartment

  BASE_URL = 'http://njuskalo.com'

  attr_reader :njuskalo_id, :relative_link, :name

  def initialize(oga_element)
    @njuskalo_id = oga_element.attributes.find { |attribute| attribute.name == 'data-ad-id' }.value
    @relative_link = oga_element.attributes.find {|attribute| attribute.name == 'data-href' }.value
    @name = oga_element.xpath('article/h3/a').text
  end

  def link
    @link ||= BASE_URL + relative_link
  end

  def attributes
    {
      njuskalo_id: njuskalo_id,
      link: link,
      name: name
    }
  end

end
