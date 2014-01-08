class HarvestService
  def initialize(organization, username, password)
    @harvest = Harvest.client(organization, username, password)
  end

  def submit_time_entry(date, notes, project_id, task_id)
    time_entry = Harvest::TimeEntry.new(
      project_id: project_id,
      task_id: task_id,
      spent_at: date,
      hours: 0.001,
      notes: notes)
    @harvest.time.create(time_entry)
  end
end
