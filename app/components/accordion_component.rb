class AccordionComponent < ViewComponent::Base
  renders_many :sections, "Section"
end
