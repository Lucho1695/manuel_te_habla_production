module ApplicationHelper
  def show_image(value)
    begin
      if value.present?
        parameter = Time.now.strftime("%Y%m%d%H%M%S%L")
        if value =~ /.pdf/i
          return image_tag( '/assets/pdf.png', style: "width:100%;")
        else
          return image_tag( value, style: "
            width: 315px;
            height: 315px;
            max-width: 100%;
            max-height: 100%;
            background-color: #eee;
            ")
        end
      end
    rescue Exception => e
      return e
    end
  end

  def show_image_profile(value)
    begin
      if value.present?
        parameter = Time.now.strftime("%Y%m%d%H%M%S%L")
        if value =~ /.pdf/i
          return image_tag( '/assets/pdf.png', style: "width:100%;")
        else
          return image_tag(
            value, style: "height: 125px;
            background-color: #eee;
            border-radius: 75%;
            white-space: nowrap;
            width: 125px;
            text-align: center;"
          )
        end
      end
    rescue Exception => e
      return e
    end
  end

  def show_image_table(value)
    begin
      if value.present?
        parameter = Time.now.strftime("%Y%m%d%H%M%S%L")
        if value =~ /.pdf/i
          return image_tag( '/assets/pdf.png', style: "width:100%;")
        else
          return image_tag(
            value, style: "height: 215px;
            background-color: #eee;
            white-space: nowrap;
            width: 215px;
            text-align: center;"
          )
        end
      end
    rescue Exception => e
      return e
    end
  end


  def show_image_say_idea(say_idea)
    begin
      onclick="(#{say_idea.title})"
      onClick2="myFunction('', '#{say_idea.title}')"
      value="#{say_idea.title}"
      id= "#{say_idea.title.gsub(' ', '')}"
      if value.present?
        parameter = Time.now.strftime("%Y%m%d%H%M%S%L")
        return image_tag( say_idea.say_idea_image + '?s=' + parameter,
          style: "
          width: 315px;
          height: 315px;
          max-width: 100%;
          max-height: 100%;
          background-color: #eee;
          white-space: nowrap;
          text-align: center;",
          class: "navButton text-white",
          onClick: onclick,
          onclick: onClick2,
          value: value + " ",
          id: id
        )
      end
    rescue Exception => e
      return e
    end
  end
end
