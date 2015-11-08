if FactoryGirl.factories.instance_variable_get('@items').empty?

FactoryGirl.define do

  factory :article do
    title "factory title"
  end

  factory :gallery do
    article
  end

  factory :image do
    content File.open "./spec/images/flower.gif"
  end

end

end
