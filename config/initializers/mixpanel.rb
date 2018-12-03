if Rails.env.external?
  $tracker = Mixpanel::Tracker.new("7225bb27783955686d3f0bd726807057")
else
  $tracker = Mixpanel::Tracker.new("fa3562bd864c1b7560da8de45460caef")
end
