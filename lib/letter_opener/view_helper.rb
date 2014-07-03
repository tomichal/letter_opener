module LetterOpener
  module ViewHelper
    def view_latest_message
      template_filepath = File.join(File.dirname(__FILE__), "view_latest_message.html.erb")
      ERB.new(File.read(template_filepath)).result(binding).html_safe
    end

    private
      def latest_message_html
        location = Rails.root.join("tmp", "letter_opener")
        absolute_filepath = Dir.glob("#{location}/*/*.html").max_by { |f| File.mtime(f) }
        if absolute_filepath
          File.read(absolute_filepath).html_safe
        end
      end
  end
end