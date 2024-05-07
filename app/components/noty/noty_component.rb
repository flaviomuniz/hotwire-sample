# rubocop:disable all

module Noty
  class NotyComponent < ViewComponent::Base
    def initialize(flash:)
      super
      @flash = flash
    end

    # Determines the color of the message based on its type
    def type_message_color
      color_mapping = {
        "success" => "green",
        "error" => "red"
      }

      # Finds the first applicable color for any of the flash message types present
      @flash.keys.map { |key| color_mapping[key] }.compact.first || 'gray'
    end

  end
end
