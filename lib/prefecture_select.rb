# -*- encoding : utf-8 -*-
# PrefectureSelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using prefecture_options_for_select to generate the list of option tags.
      def prefecture_select(object, method, priority_prefectures = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_prefecture_select_tag(priority_prefectures, options, html_options)
      end
      # Returns a string of option tags for pretty much any prefecture in the world. Supply a prefecture name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of prefectures as +priority_prefectures+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def prefecture_options_for_select(selected = nil, priority_prefectures = nil)
        prefecture_options = "".html_safe

        if priority_prefectures
          prefecture_options += options_for_select(priority_prefectures, selected)
          prefecture_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n".html_safe
          # prevents selected from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority prefecture
          selected=nil if priority_prefectures.include?(selected)
        end

        return prefecture_options + options_for_select(PREFECTURES.map{|k,v| [k,v]}.sort_by{|k,v| v }, selected)
      end
      # All the prefectures included in the prefecture_options output.
      PREFECTURES = {
      "北海道" => "01",
      "青森県" => "02",
      "岩手県" => "03",
      "宮城県" => "04",
      "秋田県" => "05",
      "山形県" => "06",
      "福島県" => "07",
      "茨城県" => "08",
      "栃木県" => "09",
      "群馬県" => "10",
      "埼玉県" => "11",
      "千葉県" => "12",
      "東京都" => "13",
      "神奈川県" => "14",
      "新潟県" => "15",
      "富山県" => "16",
      "石川県" => "17",
      "福井県" => "18",
      "山梨県" => "19",
      "長野県" => "20",
      "岐阜県" => "21",
      "静岡県" => "22",
      "愛知県" => "23",
      "三重県" => "24",
      "滋賀県" => "25",
      "京都府" => "26",
      "大阪府" => "27",
      "兵庫県" => "28",
      "奈良県" => "29",
      "和歌山県" => "30",
      "鳥取県" => "31",
      "島根県" => "32",
      "岡山県" => "33",
      "広島県" => "34",
      "山口県" => "35",
      "徳島県" => "36",
      "香川県" => "37",
      "愛媛県" => "38",
      "高知県" => "39",
      "福岡県" => "40",
      "佐賀県" => "41",
      "長崎県" => "42",
      "熊本県" => "43",
      "大分県" => "44",
      "宮崎県" => "45",
      "鹿児島県" => "46",
      "沖縄県" => "47"
      } unless const_defined?("PREFECTURES")
    end

    class InstanceTag
      def to_prefecture_select_tag(priority_prefectures, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            prefecture_options_for_select(value, priority_prefectures),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def prefecture_select(method, priority_prefectures = nil, options = {}, html_options = {})
        @template.prefecture_select(@object_name, method, priority_prefectures, options.merge(:object => @object), html_options)
      end
    end
  end
end