require 'active_support/inflector'
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'die', 'dice'
end
