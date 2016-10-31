class MomentPolicy < ApplicationPolicy
  attr_reader :user, :moment

  def initialize(user, moment)
    @user = user
    @moment = moment
  end

  %w(new? create? edit? update? destroy?).each do |m|
    define_method(m) do
      moment.story.user == user
    end
  end
end
