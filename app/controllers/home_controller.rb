class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to :user_session
    elsif !current_user.user_setting
      redirect_to :new_user_setting
    elsif !request.xhr?
      render :loading
    else
      settings = current_user.user_setting
      mapping = settings.project_mappings.first
      tracker = PivotalTrackerService.new(settings.tracker_api_token,
        mapping.external_project_id, settings.tracker_full_name)
      harvest = HarvestService.new( settings.harvest_organization,
        settings.harvest_username, settings.harvest_password)

      Time.use_zone("Mountain Time (US & Canada)") do
        @today = Time.zone.today
        @billing_period = BillingPeriod.new(@today)
        @existing_time =
          harvest.retrieve_time_entry( @billing_period.past_and_present_days,
            mapping.harvest_project_id, mapping.harvest_task_id)
        @stories = tracker.active_stories(@billing_period.past_and_present_days)
      end
    end
  end

  def submit
    settings = current_user.user_setting
    harvest = HarvestService.new( settings.harvest_organization,
      settings.harvest_username, settings.harvest_password)

    time_entry = params[:time_entry]

    time_entry.each do |date_str, hash|
      date = date_str.to_date
      new_notes = hash[:new] \
        .select { |story_id, attrs| attrs[:checked] } \
        .map { |story_id, attrs| "#{story_id} #{attrs[:name]}" } \
        .join(", \n")
      existing_entry = hash[:existing] || {}

      notes = build_notes(new_notes, existing_entry[:notes], existing_entry[:action])
      hours = hash[:hours]

      if(notes.present?)
        if(existing_entry.present?)
          harvest.update_time_entry(existing_entry[:id], notes, hours)
        else
          mapping = settings.project_mappings.first
          harvest.create_time_entry(date, notes, hours,
            mapping.harvest_project_id, mapping.harvest_task_id)
        end
      end
    end

    redirect_to :root, notice: "Your time has been submitted to Harvest!"
  end

private

  def build_notes(new_notes, existing_notes, action)
    return new_notes unless existing_notes

    case action
    when "leave"
      return existing_notes
    when "add_to"
      return "#{existing_notes}\n#{new_notes}"
    when "replace"
      return new_notes
    else
      raise "unexpected action #{action}"
    end
  end
end
