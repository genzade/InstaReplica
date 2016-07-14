include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :post do
    caption { Faker::Hipster.sentence }
    image { fixture_file_upload './spec/images/wilson_matt_n_peter.png', 'image/png' }
    # user
  end

  # factory :post do
  #   caption "MyText"
  #   image { fixture_file_upload './spec/images/wilson_matt_n_peter.png', 'image/png' }
  #   # user
  # end
  
  # factory :post_params, class: Post do
  #   caption { Faker::Hipster.sentence }
  #   image { fixture_file_upload './spec/images/wilson_matt_n_peter.png', 'image/png' }
  # end
end
