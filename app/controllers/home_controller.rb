class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to :user_session
    elsif !current_user.user_setting
      redirect_to :new_user_setting
    else
      settings = current_user.user_setting
      tracker = PivotalTrackerService.new(settings.tracker_api_token,
        settings.project_mappings.first.external_project_id,
        settings.tracker_full_name)

      @target_date = Date.today
      @billing_period = BillingPeriod.new(@target_date)
      @stories = tracker.active_stories(@billing_period.past_and_present_days)
    end
  end

  def submit
    settings = current_user.user_setting
    harvest = HarvestService.new( settings.harvest_organization,
      settings.harvest_username, settings.harvest_password)

    params[:time_entry].each do |date_str, stories|
      date = date_str.to_date
      notes = stories \
        .select { |story_id, attrs| attrs[:checked] } \
        .map { |story_id, attrs| "#{story_id} #{attrs[:name]}" } \
        .join(", \n")

      if(notes.present?)
        mapping = settings.project_mappings.first
        harvest.submit_time_entry(date, notes,
          mapping.harvest_project_id, mapping.harvest_task_id)
      end
    end

    redirect_to :root
  end
end
