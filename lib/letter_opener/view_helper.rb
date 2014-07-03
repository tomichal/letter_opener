module LetterOpener
  module ViewHelper
    def pop_email
      location = Rails.root.join("public", "letter_opener")
      filepath = Dir.glob("#{location}/*/*.html").max_by { |f| File.mtime(f) }
      if filepath
        filepath = filepath.gsub(Rails.root.join("public").to_s, "")
        <<-CONTENT
<div id="letter_opener_container">
  <style>
    #letter_opener_container {
      width: 100%;
      height: 100%;
      position: absolute;
      left: 0;
      top: 0;
    }
  </style>
  <a href="#" id="remove">Close</a>
  <script>
    jQuery("#remove").click(function(){
      $(this).closest("div").remove();
    });
  </script>
  #{content_tag(:iframe, nil, src: filepath)}
</div>
          CONTENT
      end
    end
  end
end