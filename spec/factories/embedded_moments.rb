# == Schema Information
#
# Table name: embedded_moments
#
#  id         :integer          not null, primary key
#  body       :json
#  story_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :embedded_moment do
    json_body {
      {
        "url"           =>"https://twitter.com/fahrenhei7lt/status/788802438467837952",
        "author_name"   =>"Ivan Kuznetsov",
        "author_url"    =>"https://twitter.com/fahrenhei7lt",
        "html"          =>"<blockquote class=\"twitter-tweet\"><p lang=\"en\" dir=\"ltr\">3 of 5 stars to Thinner by Richard Bachman <a href=\"https://t.co/xX0praABZ1\">https://t.co/xX0praABZ1</a></p>&mdash; Ivan Kuznetsov (@fahrenhei7lt) <a href=\"https://twitter.com/fahrenhei7lt/status/788802438467837952\">October 19, 2016 </a></blockquote>\n<script async src=\"//platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>",
        "width"         =>550,
        "height"   =>nil,
        "type"   =>"rich",
        "cache_age"   =>"3153600000",
        "provider_name"   =>"Twitter",
        "provider_url"   =>"https://twitter.com",
        "version"   =>"1.0"
      }
    }
    happened_at Time.now
    association :story
  end
end
