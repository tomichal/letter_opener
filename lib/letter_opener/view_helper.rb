module LetterOpener
  module ViewHelper
    def pop_email
      location = Rails.root.join("public", "letter_opener")
      absolute_filepath = Dir.glob("#{location}/*/*.html").max_by { |f| File.mtime(f) }
      if absolute_filepath
        html = content_tag(:div, File.read(absolute_filepath).html_safe, class: "letter_opener_container")
        `rm #{absolute_filepath}`
        html
      end
    end
  end
end