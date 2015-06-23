require 'Qt'

module TicTacToeGui
  module Ui
    class GuiBuilder
      INFO_LABEL_NAME = 'info_label'
      def initialize(parent)
        @parent = parent
      end

      def create_button(object_name, text, callback)
        button = Qt::PushButton.new(text)
        button.objectName = object_name
        @parent.connect(button, SIGNAL(:clicked), @parent, SLOT(callback))
        button
      end

      def create_label
        label = Qt::Label.new
        label.objectName = INFO_LABEL_NAME
        label
      end
    end
  end
end
