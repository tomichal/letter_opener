module LetterOpener
  module ViewHelper
    def pop_email
      location = settings[:location]
      filepath = Dir.glob("#{location}/*/*.html").max_by { |f| File.mtime(f) }
      if filepath
        filepath = filepath.gsub(Rails.root.to_s, "")
        content_tag(:iframe, nil, src: filepath)
      end
    end
  end
end