module VotingsHelper
  def question_with_attachments(voting_question, closed_flag)
    description = voting_question.description
    if closed_flag
      voting_question.update_voting_percent! unless voting_question.is_calculated?
      result = voting_question.accepted_percent > 50 ? content_tag(:span, "принято", class: "label label-success") :
          content_tag(:span, "непринято", class: "label label-warning")
      description = "#{description}"
      description << content_tag(:div, result + " За: #{voting_question.accepted_percent}%, Против: #{voting_question.discarded_percent}%", class: "align_right")
    end
    if voting_question.attachments.any?
      files = voting_question.attachments.map{ |attachment| link_to(File.basename(attachment.file.url), attachment.file.url) }.join(" ;").html_safe
      "#{description}(#{files})"
    else
      description
    end
  end
end
