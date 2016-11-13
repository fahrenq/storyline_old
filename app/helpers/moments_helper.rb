module MomentsHelper
  def render_moment(moment)
    # this method determines whatever partial we need. We have conversion of
    # classes names to snake_case, just like files in web/shared/moments/*.slim
    render partial: "web/shared/moments/#{moment.class.to_s.underscore}",
           locals: { moment: moment }
  end
end
