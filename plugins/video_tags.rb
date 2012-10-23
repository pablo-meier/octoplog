module Jekyll
    # Just a few hackjobs to do Youtube/Vimeo embeds in a more dynamic fashion
    # pablo.a.meier@gmail.com
    class YoutubeTag < Liquid::Tag

        WIDTH  = 500.to_s
        HEIGHT = 305.to_s
#        WIDTH  = 640.to_s
#        HEIGHT = 390.to_s

        YOUTUBE_WEB_BASE = /http:\/\/www\.youtube\.com\/watch\?v=([a-zA-Z0-9\-_]+)/
        YOUTUBE_PLAYER_BASE = "https://www.youtube.com/v/"
        
        def initialize(tag_name, url, tokens)
            super
            @url = url
        end

# "better" youtube linking syntax causes something to lock up when generating the site:
# something failed and Jekyll refused to generate any more of the site.  This currently
# uses the old syntax, but for posterity, in the future maybe we can make the iframe work.
#        YOUTUBE_PLAYER_BASE = "http://www.youtube.com/embed/"
# <iframe title="YouTube video player" width="#{WIDTH}" height="#{HEIGHT}" src="#{sub_url}" frameborder="0" allowfullscreen="true"></iframe>

        def render(context)
            video_id = @url.match(YOUTUBE_WEB_BASE)[1]
            sub_url = YOUTUBE_PLAYER_BASE + video_id
<<-HTML
<div style="width: #{WIDTH}px; margin: 15px auto;"><object width="#{WIDTH}" height="#{HEIGHT}"><param name="movie" value="#{sub_url}"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="#{sub_url}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="#{WIDTH}" height="#{HEIGHT}"></embed></object></div>
HTML
        end

    end

    Liquid::Template.register_tag('youtube', YoutubeTag)


    class VimeoTag < Liquid::Tag

        WEB_URL_BASE = /http:\/\/vimeo\.com\/(\d+)/
        PLAYER_URL_BASE = "http://vimeo.com/moogaloop.swf?clip_id="
        PLAYER_URL_SUFFIX = "&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=1&amp;color=00ADEF&amp;fullscreen=1&amp;autoplay=0&amp;loop=0"
        WIDTH  = 500.to_s
        HEIGHT = 305.to_s


        def initialize(tag_name, url, tokens)
            super
            @url = url
        end

        def render(context)
            video_id = @url.match(WEB_URL_BASE)[1]
            embed_url = PLAYER_URL_BASE + video_id + PLAYER_URL_SUFFIX
<<-HTML
<div style="width: #{WIDTH}px; margin: 15px auto;"><object width="#{WIDTH}" height="#{HEIGHT}"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="#{embed_url}" /><embed src="#{embed_url}" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="#{WIDTH}" height="#{HEIGHT}"></embed></object></div>
HTML
        end
    end

    Liquid::Template.register_tag('vimeo', VimeoTag)
end
