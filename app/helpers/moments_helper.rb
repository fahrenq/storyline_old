module MomentsHelper
  def render_moment(moment)
    if moment.is_a?(NativeMoment)
      render partial: 'web/shared/moments/native_moment', locals: { moment: moment }
    elsif moment.is_a?(EmbeddedMoment)
      render partial: 'web/shared/moments/embedded_moment', locals: { moment: moment }
    end
  end
end
