require 'Qt'

RSpec::Matchers.define :have_label_with_text do |expected|
  match do |widget|
    widget.children.any? do |child|
      child.kind_of?(Qt::Label) and child.text==expected
    end
  end
end
