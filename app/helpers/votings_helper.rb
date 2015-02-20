module VotingsHelper
  def question_with_attachments(voting_question, closed_flag)
    description = voting_question.description
    if closed_flag
      voting_question.update_voting_percent! unless voting_question.is_calculated?
      description = "#{description} За: #{voting_question.accepted_percent}%, Против: #{voting_question.discarded_percent}%"
    end
    if voting_question.attachments.any?
      files = voting_question.attachments.map{ |attachment| link_to(File.basename(attachment.file.url), attachment.file.url) }.join(" ;").html_safe
      "#{description}(#{files})"
    else
      description
    end
  end
end
