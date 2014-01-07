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
end
