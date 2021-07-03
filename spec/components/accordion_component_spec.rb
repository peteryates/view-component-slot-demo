require 'rails_helper'

describe AccordionComponent, type: :component do
  let(:lookup_context) { ActionView::LookupContext.new(ActionController::Base.view_paths) }
  let(:assigns) { {} }                                                                     
  let(:controller) { ActionController::Base.new }                                          
  let(:helper) { ActionView::Base.new(lookup_context, assigns, controller) }               

  # this works as expected
  describe "using args" do
    before do
      render_inline(AccordionComponent.new) do |accordion|
        accordion.section(heading_text: "one") { "one content" }
        accordion.section(heading_text: "two") { "two content" }
        accordion.section(heading_text: "three") { "three content" }
      end
    end

    specify "renders the accordion with all sections" do
      expect(rendered_component).to have_tag('ol') do
        with_tag('li', class: 'one') do
          with_tag('h3', text: 'one')
          with_tag('div', text: 'one content')
        end

        with_tag('li', class: 'two') do
          with_tag('h3', text: 'two')
          with_tag('div', text: 'two content')
        end

        with_tag('li', class: 'three') do
          with_tag('h3', text: 'three')
          with_tag('div', text: 'three content')
        end
      end
    end
  end

  # this does not, cannot get the content passed into #heading_html to
  # be dealt with correctly. tried safe_join, capture etc.
  describe "using blocks" do
    before do
      render_inline(AccordionComponent.new) do |accordion|
        accordion.section do |section|
          section.heading_html do
            "custom heading one"
          end

          "one content"
        end
      end
    end

    specify "renders the accordion with all sections" do
      expect(rendered_component).to have_tag('ol') do
        with_tag('li', class: 'one') do
          with_tag('h3', text: 'custom heading one')
          with_tag('div', text: 'one content')
        end
      end
    end
  end
end
