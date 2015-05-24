class ApartmentParser

  BASE_URL = 'http://www.njuskalo.hr'

  attr_reader :njuskalo_id, :relative_link, :name

  def initialize(oga_element)
    @njuskalo_id = oga_element.attributes.find { |attribute| attribute.name == 'data-ad-id' }.value.to_i
    @relative_link = oga_element.attributes.find {|attribute| attribute.name == 'data-href' }.value
    # @name = oga_element.xpath('article/h3/a').text
    @name = @relative_link.match(/\A\/nekretnine\/(.*)-oglas/).captures.first.tr('-', ' ').capitalize
  end

  def link
    @link ||= BASE_URL + relative_link
  end
end
