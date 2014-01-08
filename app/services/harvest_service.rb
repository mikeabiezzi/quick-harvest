class HarvestService
  def initialize(organization, username, password)
    @harvest = Harvest.client(organization, username, password)
  end

  def create_time_entry(date, notes, hours, project_id, task_id)
    hours = 0.001 if hours == 0 # 0.001 creates an entry of 0 hours and prevents the timer from starting

    time_entry = Harvest::TimeEntry.new(
      project_id: project_id,
      task_id: task_id,
      spent_at: date,
      hours: hours,
      notes: notes)
    @harvest.time.create(time_entry)
  end

  def update_time_entry(id, notes, hours)
    time_entry = @harvest.time.find(id)
    time_entry.notes = notes
    time_entry.hours = hours
    @harvest.time.update(time_entry)
  end

  def retrieve_time_entry(dates, project_id, task_id)
    if(dates.is_a?(Array))
      dates.map { |d| retrieve_time_entry(d, project_id, task_id) }.flatten
    else
      date = dates
      @harvest.time.all(date).select do |time_entry|
        time_entry["project_id"] == project_id &&
          time_entry["task_id"] == task_id
      end
    end
  end
end
