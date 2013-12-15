module.exports = ->
  # class @PivotalTracker.Resources.Project extends @Restive.Resource
  #   @schema 'writable', 'required', ->
  #     name:                              @a String, ofLength: '1..50'

  #   @schema 'writable', ->
  #     no_owner:                          @a Boolean
  #     number_of_done_iterations_to_show: @an 'Integer'
  #     account_id:                        @an 'Integer'
  #     atom_enabled:                      @a Boolean
  #     profile_content:                   @a String, ofLength: '0..65535'
  #     velocity_averaged_over:            @an 'Integer'
  #     start_date:                        @a Date
  #     point_scale:                       @a String, ofLength: '0..255'
  #     week_start_day:                    @a 'DayOfTheWeek'
  #     description:                       @a String, ofLength: '0..140'
  #     enable_planned_mode:               @a Boolean
  #     enable_incoming_emails:            @a Boolean
  #     time_zone:                         @a 'TimeZone'
  #     enable_tasks:                      @a Boolean
  #     public:                            @a Boolean
  #     initial_velocity:                  @an 'Integer'
  #     bugs_and_chores_are_estimatable:   @a Boolean
  #     iteration_length:                  @an 'Integer'

  #   @schema ->
  #     id:                                @an 'Integer'
  #     enable_following:                  @a Boolean
  #     current_velocity:                  @an 'Integer'
  #     version:                           @an 'Integer'
  #     has_google_domain:                 @a Boolean
  #     kind:                              @a String
  #     current_iteration_number:          @an 'Integer'
  #     shown_iterations_start_time:       @a 'Datetime'
  #     created_at:                        @a 'Datetime'
  #     point_scale_is_custom:             @a Boolean
  #     start_time:                        @a 'Datetime'
  #     updated_at:                        @a 'Datetime'
  #     story_ids:                         [@an 'Integer']
  #     epic_ids:                          [@an 'Integer']
  #     label_ids:                         [@an 'Integer']
  #     integration_ids:                   [@an 'Integer']
  #     membership_ids:                    [@an 'Integer']
  #     iteration_override_numbers:        [@an 'Integer']
