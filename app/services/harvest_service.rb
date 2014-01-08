class HarvestService
  def initialize(organization, username, password)
    @harvest = Harvest.client(organization, username, password)
  end

  def submit_time_entry(date, notes, project_id, task_id, hours = 0)
    # hours = 0.001 creates an entry of 0 hours and prevents the timer from starting
    hours = 0.001 if hours == 0

    time_entry = Harvest::TimeEntry.new(
      project_id: project_id,
      task_id: task_id,
      spent_at: date,
      hours: hours,
      notes: notes)
    @harvest.time.create(time_entry)
  end
end
