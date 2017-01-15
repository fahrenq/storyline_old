module GlobalViewsHelper
  def active_class(controller, actions)
    'active' if controller == controller_name && [*actions].include?(action_name)
  end
end
