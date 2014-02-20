# TODO: This needs some specs bad..
class PivotalTrackerService
  def initialize(token, project_id, names)
    @name = names.reject{ |n| n.blank? }.join("|")
    @project_id = project_id

    PivotalService.set_token(token)
  end

  def active_stories(dates)
    occurred_after = (dates.min - 1.day).to_time.to_i
    recent_activities = PivotalService.activity(@project_id, 0, occurred_after)

    users_recent_activities =
      recent_activities.select do |activity|
        activity[:message] =~ /#{@name}/ &&
          activity[:message] =~ /completed task|started|accepted.*chore|finished/ &&
          dates.include?(Time.zone.parse(activity[:occurred_at]).to_date)
      end

    users_recent_activities.map do |activity|
      activity[:primary_resources].map { |x| {
        date: Time.zone.parse(activity[:occurred_at]).to_date,
        id: x[:id], name: x[:name] } }
    end \
    .flatten \
    .uniq
  end
end
