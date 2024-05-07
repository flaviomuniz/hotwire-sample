# rubocop:disable all

module Noty
  class NotyComponent < ViewComponent::Base

    def initialize(flash:)
      super
      @flash = flash
    end

    def type_message_color
      color_mapping = {
        "success" => "green",
        "error" => "red"
      }
      @flash.keys.map { |key| color_mapping[key] }.compact.first || 'gray'
    end

  end
end
