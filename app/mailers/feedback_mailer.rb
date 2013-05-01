class FeedbackMailer < ActionMailer::Base

  def feedback_email(feedback)
    @feedback = feedback
    mail( subject:"You've got feedback!",
          to: "Andrew Harris<me@drew-harris.com>, Evan Moore<etmoore@gmail.com>, James Kobol<jim.kobol@gmail.com>")
  end
end
