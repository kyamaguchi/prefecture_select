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

        return prefecture_options + options_for_select(PREFECTURES, selected)
      end
      # All the prefectures included in the prefecture_options output.
      PREFECTURES = ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"] unless const_defined?("PREFECTURES")
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