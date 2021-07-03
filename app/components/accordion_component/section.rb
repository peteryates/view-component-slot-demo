class AccordionComponent
  class Section < ViewComponent::Base
    renders_one :heading_html

    attr_reader :heading_text

    def initialize(heading_text: nil)
      @heading_text = heading_text
    end

    def heading
      heading_text || heading_html
    end
  end
end
