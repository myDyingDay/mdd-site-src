# my dyingDay caffaine

# Set static domain to e.g. `//mystatic.domain.com` to prepend a custom domain to your ressources

staticDomain = ''

OpenAlbum = (strAlbum, strTrack) ->
  albumSelector = ''
  albumTrackList = ''
  albumCoverUrl = ''
  albumTitle = ''
  TrackSelected = undefined
  albumiTunesID = ''
  albumiTunesSlug = ''
  albumSpotifyID = ''
  iTunesUrl = ''
  spotifyUrl = ''
  reverbNationUrl = ''
  reverbNationSlug = ''
  bandCampUrl = ''
  bandCampSlug = ''
  soundCloudUrl = ''
  trackTitle = ''
  $('.popover').remove()
  $.ajaxSetup cache: true
  # alert(strAlbum)
  $.getJSON('/json/albums.json', (data) ->
    $.each data.albums, (i, item) ->
      albumName = item.Name
      albumID = item.ID
      albumCover = item.Cover
      if strAlbum == albumID
        albumSelector += '''
          <a
            href="javascript:;"
            data-album-id="''' + albumID + '''"
            data-track-number="01"
          >
            <img
              src="''' + albumCover + '''"
              class="active"
              style="width:50px;"
            />
          </a>
          '''
        albumTitle = albumName
        albumCoverUrl = albumCover
        albumiTunesID = item.iTunesID
        albumiTunesSlug = item.iTunesSlug
        Tracks = item.Tracks
        t = 0
        while t < Tracks.length
          if strTrack == Tracks[t].number
            TrackSelected = Tracks[t]
            iTunesUrl = Tracks[t].itunes
            spotifyUrl = Tracks[t].spotify
            reverbNationUrl = Tracks[t].reverbnation
            reverbNationSlug = Tracks[t].reverbslug
            bandCampUrl = Tracks[t].bandcamp
            bandCampSlug = Tracks[t].bandcampslug
            soundCloudUrl = Tracks[t].soundcloud
            trackTitle = '<small class="text-muted">' + Tracks[t].number + '</small> ' + Tracks[t].title + ' <small class="text-muted">' + Tracks[t].duration + '</small> '
            albumTrackList += '<li class="active"><small>' + Tracks[t].number + '</small> <span class="glyphicon glyphicon-play"></span> ' + Tracks[t].title + ' <small class="text-muted">' + Tracks[t].duration + '</small></li>'
          else
            albumTrackList += '<li onclick="OpenAlbum(\'' + albumID + '\', \'' + Tracks[t].number + '\');"><small class="text-muted">' + Tracks[t].number + '</small> ' + Tracks[t].title + ' <small class="text-muted">' + Tracks[t].duration + '</small></li>'
          t++
      else
        albumSelector += '<a href="javascript:;" onclick="OpenAlbum(\'' + albumID + '\', \'01\')"><img src="' + albumCover + '" style="width:50px;" /></a> '
      return
    s = '<div id="playerouter" data-container="body" data-toggle="popover" data-placement="left" data-content="Press PLAY to start the track ...">'
    d = ''
    if reverbNationUrl.length > 0
      s += '''
        <iframe
          class="widget_iframe"
          src="http://www.reverbnation.com/widget_code/html_widget/artist_2828114?widget_id=50&pwc[design]=customized&pwc[background_color]=%23000000&pwc[included_songs]=0&pwc[song_ids]=''' + reverbNationUrl + '''&pwc[photo]=0&pwc[size]=fit"
          width="100%"
          height="80"
          frameborder="0"
          scrolling="no"
        ></iframe>'''
    else if spotifyUrl.length > 0
      s += '''
        <iframe
          class="widget_iframe"
          src="https://embed.spotify.com/?uri=spotify:track:''' + spotifyUrl + '''&theme=dark&view=list"
          width="100%"
          height="80"
          frameborder="0"
          allowtransparency="true"
        ></iframe>'''
    else if iTunesUrl.length > 0
    else if bandCampUrl.length > 0
      s += '''
        <iframe
          style="border: 0; width: 100%; height: 142px;"
          src="http://bandcamp.com/EmbeddedPlayer/track=''' + bandCampUrl + '''/size=large/bgcol=333333/linkcol=ffffff/tracklist=false/artwork=none/transparent=true/"
          seamless>
            <a
              href="http://officialmydyingday.bandcamp.com/track/nihilism"
            >
              Nihilism by my dyingDay
            </a>
        </iframe>
      '''
    else if soundCloudUrl.length > 0
      s += '''
        <iframe
          width="100%"
          height="166"
          scrolling="no"
          frameborder="no"
          src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/''' + soundCloudUrl + '''&amp;auto_play=true&amp;hide_related=true&amp;visual=false&amp;show_artwork=false"
        >
        </iframe>'''

    s += '</div>'
    if reverbNationUrl.length > 0
      d += '''
        <a
          href="http://www.reverbnation.com/mydyingday/song/''' + reverbNationUrl + '''-''' + reverbNationSlug + '''"
          target="_blank"
        >
          <img src="''' + staticDomain + '''/img/badge_reverb-lrg.png" />
        </a>
      '''
    if iTunesUrl.length > 0
      d += '''
        <a
          href="http://itunes.apple.com/dk/album/''' + albumiTunesSlug + '''/id''' + albumiTunesID + '''?i=''' + iTunesUrl + '''"
          target="_blank"
        >
          <img src="''' + staticDomain + '''/img/badge_itunes-lrg.png" />
        </a>
      '''
    if spotifyUrl.length > 0
      d += '<a href="https://play.spotify.com/track/' + spotifyUrl + '" target="_blank"><img src="' + staticDomain + '/img/badge_spotify-lrg.png" /></a> '
    if bandCampUrl.length > 0
      d += '<a href="http://officialmydyingday.bandcamp.com/track/' + bandCampSlug + '" target="_blank"><img src="' + staticDomain + '/img/badge_bandcamp-lrg.png" /></a> '
    d = '<div class="playerdownloadicons">' + d + '</div>'
    $('#playermodaltitle').html albumTitle
    $('#playermodalbody').html '<div class="pull-left playercover"><div class="coverwrapper"><img src="' + albumCoverUrl + '" style="width:100%;" /></div><div id="playeralbums">' + albumSelector + '</div></div><div class="pull-left playercontentcol"><div class="playercontenttitle"><h4>' + trackTitle + '</h4></div>' + s + ' ' + d + '<ul class="albumtracklist"><li class="tracklistheader">Tracklist:</li>' + albumTrackList + '</ul></div><div class="clearfix"></div>'
    $('#playerwin').modal 'show'
    setTimeout (->
      $('#playerouter').popover 'show'
      setTimeout (->
        $('#playerouter').popover 'hide'
        return
      ), 2000
      return
    ), 1000
    $('#playerwin').on 'hide.bs.modal', (e) ->
      $('.popover').remove()
      return
    return
  ).error (jqXHR, textStatus, errorThrown) ->
    error = ''
    if jqXHR.status == 0
      error = 'Connection problem. Check file path and www vs non-www in getJSON request'
    else if jqXHR.status == 404
      error = 'Requested page not found. [404]'
    else if jqXHR.status == 500
      error = 'Internal Server Error [500].'
    else if errorThrown == 'parsererror'
      error = 'Requested JSON parse failed.'
    else if errorThrown == 'timeout'
      error = 'Time out error.'
    else if errorThrown == 'abort'
      error = 'Ajax request aborted.'
    else
      error = 'Uncaught Error.\n' + jqXHR.responseText
    console.log 'Error fetching album data: ' + error
    return
  return

playVideo = (idVid, title) ->
  $('#videoplayer').html '<div style="padding:100px;text-align:center;font-size:20px;">Loading video ...</div>'

  s = '''
    <div
      style="background-color:rgba(0, 0, 0, 0.5);
      border-top:1px solid #FFF"
      >
      <div class="container">
        <div class="pull-left" style="width:80%; overflow:hidden;">
          <h3>
            <span class="glyphicon glyphicon-expand" ></span>
            Video: ''' + title + '''
          </h3>
        </div>

        <div class="pull-right">
          <span
            class="close"
              onclick="$('#videoplayer').html('');"
              style="
                font-size: 51px;
                font-weight: bold;
                line-height: 1;
                color: #FFF;
                text-shadow: 0 1px 0 #fff;
                opacity: .9;
                filter: alpha(opacity=90);
                ">&times;</span>
        </div>
      </div>
    </div>

    <div style="border-bottom:1px solid #FFF;padding-bottom:20px;margin-bottom:15px;background-color:rgba(0, 0, 0, 0.5);">
      <div class="videoembed">
        <div class="videowrapper">
          <div class="videocontainer">
            <iframe class="videoembedx youtube" src="//www.youtube.com/embed/''' + idVid + '''" frameborder="0" allowfullscreen=""></iframe>
          </div>
        </div>
      </div>
    </div>
  '''
  $('#videoplayer').html s
  return

(->

  page_scroll_section = ->
    page_scroll_window_scrolltop = jQuery(window).scrollTop()
    jQuery('#site-nav a').each ->
      page_scroll_link = jQuery(this)
      page_scroll_li = jQuery(this).parent()
      page_scroll_panel = jQuery(this).attr('href')
      page_scroll_panel = page_scroll_panel.replace('#', '')
      jQuery('.xpanel').each ->
        if page_scroll_window_scrolltop > jQuery(this).offset().top - 200 and page_scroll_window_scrolltop < jQuery(this).offset().top + jQuery(this).outerHeight()
          if jQuery(this).attr('id') == page_scroll_panel
            page_scroll_li.addClass 'active'
          else
            page_scroll_li.removeClass 'active'
        return
      return
    return

  addlinks = (data) ->
    data = data.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, (url) ->
      '<a href="' + url + '"  target="_blank">' + url + '</a>'
    )
    data = data.replace(/\B@([_a-z0-9]+)/ig, (reply) ->
      '<a href="http://twitter.com/' + reply.substring(1) + '" style="font-weight:lighter;" target="_blank">' + reply.charAt(0) + reply.substring(1) + '</a>'
    )
    data = data.replace(/\B#([_a-z0-9]+)/ig, (reply) ->
      '<a href="https://twitter.com/search?q=' + reply.substring(1) + '" style="font-weight:lighter;" target="_blank">' + reply.charAt(0) + reply.substring(1) + '</a>'
    )
    data

  relative_time = (time_value) ->
    values = time_value.split(' ')
    time_value = values[1] + ' ' + values[2] + ', ' + values[5] + ' ' + values[3]
    parsed_date = Date.parse(time_value)
    relative_to = if arguments.length > 1 then arguments[1] else new Date
    delta = parseInt((relative_to.getTime() - parsed_date) / 1000)
    shortdate = time_value.substr(4, 2) + ' ' + time_value.substr(0, 3)
    delta = delta + relative_to.getTimezoneOffset() * 60
    if delta < 60
      '1m'
    else if delta < 120
      '1m'
    else if delta < 60 * 60
      parseInt(delta / 60).toString() + 'm'
    else if delta < 120 * 60
      '1h'
    else if delta < 24 * 60 * 60
      parseInt(delta / 3600).toString() + 'h'
    else if delta < 48 * 60 * 60
      shortdate
    else
      shortdate

  $('#header').sticky topSpacing: 0
  jQuery(window).scroll ->
    if jQuery(window).width() > 640
      if jQuery(window).scrollTop() > jQuery(window).height() - 200
      else
    return
  page_nav = ''
  jQuery('a').click ->
    page_nav = jQuery(this).attr('href')
    if page_nav.search('#') >= 0 and page_nav.length > 2 and page_nav != '#myCarousel'
      jQuery('html,body').animate { 'scrollTop': jQuery('' + page_nav).offset().top - 40 }, 600
      if jQuery('html').hasClass('lt-ie9')
        jQuery('body').hasClass 'no-history'
      else
        window.history.pushState ', ', page_nav
      return false
    return
  page_scroll_window_scrolltop = 0
  page_scroll_panel = ''
  page_scroll_link = ''
  page_scroll_li = ''
  jQuery(window).resize ->
    page_scroll_section()
    return
  jQuery(window).scroll ->
    page_scroll_section()
    return
  jQuery(window).load ->
    web_address = location.href
    if web_address.search('#') > 0
      web_address = web_address.split('#')
      page_nav = web_address[1]
      jQuery('html,body').animate { 'scrollTop': jQuery('#' + page_nav).offset().top - 60 }, 600
    return
  displaylimit = 5
  twitterprofile = 'mydyingdayrocks'
  screenname = 'my dyingDay'
  showdirecttweets = false
  showretweets = false
  showtweetlinks = true
  showprofilepic = false
  showtweetactions = false
  showretweetindicator = false
  $('#twitter-feed').html 'Loading tweets ...'
  $.ajaxSetup cache: true
  $.getJSON('/json/tweets.json', (feeds) ->
    feedHTML = ''
    feedIndex = ''
    feedBody = ''
    displayCounter = 1
    i = 0
    while i < feeds.length
      tweetscreenname = feeds[i].user.name
      tweetusername = feeds[i].user.screen_name
      profileimage = feeds[i].user.profile_image_url_https
      status = feeds[i].text
      isaretweet = false
      isdirect = false
      tweetid = feeds[i].id_str
      if typeof feeds[i].retweeted_status != 'undefined'
        profileimage = feeds[i].retweeted_status.user.profile_image_url_https
        tweetscreenname = feeds[i].retweeted_status.user.name
        tweetusername = feeds[i].retweeted_status.user.screen_name
        tweetid = feeds[i].retweeted_status.id_str
        status = feeds[i].retweeted_status.text
        isaretweet = true
      if feeds[i].text.substr(0, 1) == '@'
        isdirect = true
      if (showretweets == true or isaretweet == false and showretweets == false) and (showdirecttweets == true or showdirecttweets == false and isdirect == false)
        if feeds[i].text.length > 1 and displayCounter <= displaylimit
          if showtweetlinks == true
            status = addlinks(status)
          carouselClass = ''
          if displayCounter == 1
            carouselClass = 'active'
          else
          feedHTML += '''
            <div class="twitter-article" id="tw''' + displayCounter + '''">
              <div class="twitter-text">
                <p>
                  <span class="tweet-time">
                    <a
                      href="https://twitter.com/''' + tweetusername + '''/status/''' + tweetid + '''"
                      target="_blank"
                    >
                      ''' + relative_time(feeds[i].created_at) + '''
                    </a>
                  </span>
                  ''' + status + '''
                </p>
          '''

          if isaretweet == true and showretweetindicator == true
            feedHTML += '<div id="retweet-indicator"></div>'
          if showtweetactions == true
            feedHTML += '''
              <div id="twitter-actions">
                <div class="intent" id="intent-reply">
                  <a
                    href="https://twitter.com/intent/tweet?in_reply_to=''' + tweetid + '''"
                    title="Reply"
                  ></a>
                </div>
                <div class="intent" id="intent-retweet">
                  <a
                    href="https://twitter.com/intent/retweet?tweet_id=''' + tweetid + '''"
                    title="Retweet"
                  ></a>
                </div>
                <div class="intent" id="intent-fave">
                  <a
                    href="https://twitter.com/intent/favorite?tweet_id=''' + tweetid + '''"
                    title="Favourite"
                  ></a>
                </div>
              </div>
            '''
          feedHTML += '</div>'
          feedHTML += '</div>'
          feedIndex += '<li data-target="#carousel-example-generic" data-slide-to="' + displayCounter - 1 + '" class="' + carouselClass + '"></li>'
          feedBody += '<div class="item ' + carouselClass + '"><div class="carousel-caption"><small class="text-muted">' + relative_time(feeds[i].created_at) + '</small> ' + status + '</div></div>'
          displayCounter++
      i++
    twrap = '''
      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

        <!-- Indicators -->
        <ol class="carousel-indicators">''' + feedIndex + '''</ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">''' + feedBody + '''</div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
        </a>

      </div>

      '''
    $('#twitter-feed').html twrap
    $('.carousel').carousel()
    if showtweetactions == true
      $('.twitter-article').hover (->
        $(this).find('#twitter-actions').css
          'display': 'block'
          'opacity': 0
          'margin-top': -20
        $(this).find('#twitter-actions').animate {
          'opacity': 1
          'margin-top': 0
        }, 200
        return
      ), ->
        $(this).find('#twitter-actions').animate {
          'opacity': 0
          'margin-top': -20
        }, 120, ->
          $(this).css 'display', 'none'
          return
        return
      $('#twitter-actions a').click ->
        url = $(this).attr('href')
        window.open url, 'tweet action window', 'width=580,height=500'
        false
    return
  ).error (jqXHR, textStatus, errorThrown) ->
    error = ''
    if jqXHR.status == 0
      error = 'Connection problem. Check file path and www vs non-www in getJSON request'
    else if jqXHR.status == 404
      error = 'Requested page not found. [404]'
    else if jqXHR.status == 500
      error = 'Internal Server Error [500].'
    else if errorThrown == 'parsererror'
      error = 'Requested JSON parse failed.'
    else if errorThrown == 'timeout'
      error = 'Time out error.'
    else if errorThrown == 'abort'
      error = 'Ajax request aborted.'
    else
      error = 'Uncaught Error.\n' + jqXHR.responseText
    console.log 'Error fetching twitter feed: ' + error
    return
  return
) jQuery

