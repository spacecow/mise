if FactoryGirl.factories.instance_variable_get('@items').empty?

FactoryGirl.define do

  factory :article do
  end

  factory :gallery do
    article
  end

  factory :image do
  end

end

end
