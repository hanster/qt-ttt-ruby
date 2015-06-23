require 'Qt'

module TicTacToeGui
  module Ui
    class MenuGroup
      def initialize(group_name, options)
        radio_buttons = create_radio_buttons(options)
        @group_box = create_group_box(group_name, radio_buttons)
        @button_group = create_button_group(group_name, radio_buttons)
      end

      def group_box
        @group_box
      end

      def selected_option
        @button_group.checkedButton.text
      end

      private

      def create_radio_buttons(options)
        options.reduce([]) do |radio_buttons, option|
          radio_button = Qt::RadioButton.new(option)
          radio_button.objectName = option
          radio_buttons << radio_button
        end
      end

      def create_button_group(name, buttons)
        button_group = Qt::ButtonGroup.new
        button_group.objectName = name
        buttons.each do |button|
          button_group.addButton(button)
        end
        default_button = button_group.buttons.first
        default_button.setChecked(true)
        button_group
      end

      def create_group_box(object_name, radio_buttons)
        group = Qt::GroupBox.new(object_name)
        layout = Qt::VBoxLayout.new(group)
        radio_buttons.each do |radio_button|
          layout.addWidget(radio_button)
        end
        group
      end
    end
  end
end
