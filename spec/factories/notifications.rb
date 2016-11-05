FactoryGirl.define do
  factory :notification do
    body 'MyString'
    category :new_moment
    info {
      {
        'story_id'    => 1,
        'story_title' => 'MyTitle'
      }
    }
  end
end
