module Clear
  extend ActiveSupport::Concern

  module ClassMethods
    def clear!
      sub_class = eval name
      sub_class.all.each do |sc|
        sc.destroy
      end
    end
  end
end
