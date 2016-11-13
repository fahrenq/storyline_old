module MomentsHelper
  def render_moment(moment)
    render partial: "web/shared/moments/#{moment.class.to_s.underscore}",
           locals: { moment: moment }
  end
end
