module LetterOpener
  module ViewHelper
    def pop_email
      location = Rails.root.join("public", "letter_opener")
      absolute_filepath = Dir.glob("#{location}/*/*.html").max_by { |f| File.mtime(f) }
      if absolute_filepath
        filepath = absolute_filepath.gsub(Rails.root.join("public").to_s, "")
        html = <<-CONTENT
<div id="letter_opener_container">
  <style>
    #remove {
      float: left;
    }
    #letter_opener_container {
      width: 100%;
      height: 100%;
      position: absolute;
      left: 0;
      top: 0;
    }
    #letter_opener_container iframe {
      width: 100%;
      height: 100%;
      background-color: rgba(100,100,100,0.5);
    }
  </style>
  <h1>
    <a href="#" id="remove">Close</a>
  </h1>

  #{content_tag(:iframe, nil, src: "about:blank", id: "letter_opener_iframe")}
  <script>
    jQuery("#remove").click(function(){
      $(this).closest("div").remove();
    });
    var doc = document.getElementById('letter_opener_iframe').contentWindow.document;
    doc.open();
    doc.write('#{escape_javascript(File.read(absolute_filepath))}');
    doc.close();
  </script>
</div>
          CONTENT
        `rm #{absolute_filepath}`
        html.html_safe
      end
    end
  end
end