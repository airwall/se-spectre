module ApplicationHelper
  def active_class?(path)
    return 'active' if request.path.to_s.include?(path)
    ''
  end
end
