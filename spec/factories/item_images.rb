FactoryBot.define do

  factory :item_image do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/images/spec.jpg'), 'image/jpeg') }
    item
  end
end
