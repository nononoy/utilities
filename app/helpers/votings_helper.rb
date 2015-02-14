module VotingsHelper
  def question_with_attachments(voting_question)
    if voting_question.attachments.any?
      files = voting_question.attachments.map{ |attachment| link_to(File.basename(attachment.file.url), attachment.file.url) }.join(" ;").html_safe
      "#{voting_question.description}(#{files})"
    else
      voting_question.description
    end
  end
end
