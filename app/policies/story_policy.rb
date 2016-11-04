class StoryPolicy < ApplicationPolicy
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  %w(edit? update? destroy?).each do |m|
    define_method(m) do
      story.user == user
    end
  end

  def subscribe?
    story.user != user && story.subscribers.exclude?(user)
  end
end
