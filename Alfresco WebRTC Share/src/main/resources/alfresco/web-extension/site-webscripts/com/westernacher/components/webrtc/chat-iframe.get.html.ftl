<!DOCTYPE html>
<html>
    <head>
        <!--<script src="http://simplewebrtc.com/latest.js"></script>-->
        <!--<script src="/share/components/webrtc-chat/latest.js"></script>-->
        
        <script src="/share/components/webrtc-chat/jquery-1.10.2.min.js"></script>
        <script src="/share/components/webrtc-chat/socket.io.js"></script>
        <script src="/share/components/webrtc-chat/simplewebrtc.bundle.js"></script>
        
   <style type="text/css" media="screen">
      @import url("/share/res/css/yui-fonts-grids.css");
      @import url("/share/res/yui/columnbrowser/assets/columnbrowser.css");
      @import url("/share/res/yui/columnbrowser/assets/skins/default/columnbrowser-skin.css");
      @import url("/share/res/themes/greenTheme/yui/assets/skin.css");
      @import url("/share/res/css/base.css");
      @import url("/share/res/css/yui-layout.css");
      @import url("/share/res/themes/greenTheme/presentation.css");
   </style>
        
    </head>
    <body>
        <style>
        	#localVideo {
                height: 150px;
            }
            
            .remoteVideos video {
                height: 150px;
            }
        </style>


<div class="alfresco-share">
	<div class="yui-g">
         <div class="yui-u first">
              <div id="body" class="chat">
				<div id="chatwindow">
				 <div id="messages">
				    <p>Daniel wrote: Great party yesterday</p>
				    <p>Alex wrote: stil hungover</p>
				    <p>Chris: great party? nah.</p>
				    <p>Sam: what party</p>
				    <p>jenny: partytime!</p>
				    <p>Daniel wrote: Great party yesterday</p>
				    <p>Alex wrote: stil hungover</p>
				    <p>Chris: great party? nah.</p>
				    <p>Sam: what party</p>
				    <p>jenny: partytime!</p>
				    <p>Daniel wrote: Great party yesterday</p>
				    <p>Alex wrote: stil hungover</p>
				    <p>Chris: great party? nah.</p>
				    <p>Sam: what party</p>
				    <p>jenny: partytime!</p>
				 </div>
				</div>
				
				<div class="yui-gd">
				   <div class="yui-u first"><label for="message"	>${msg("label.message")}:</label></div>
				   <div class="yui-u"><input id="chatinput" type="text" name="title" tabindex="0" maxlength="255" placeholder="Message:" /></div>
				   <div class="yui-button"><button id="email">${msg("label.post")}</button></div>
				 </div>
				 
				 </div>
           </div>
         <div class="yui-u">		 
				<div id="body" class="video">
        		<video id="localVideo"></video>
        		<div id="remoteVideos"></div>
              </div>
 		</div>
 		<button id="screenShareButton" style="display:none;"></button>
 </div>
        
        <script>
            // grab the room from the URL
            var room = location.search && location.search.split('?')[1];

            // create our webrtc connection
            var webrtc = new SimpleWebRTC({
                // the id/element dom element that will hold "our" video
                localVideoEl: 'localVideo',
                // the id/element dom element that will hold remote videos
                remoteVideosEl: 'remoteVideos',
                // immediately ask for camera access
                autoRequestMedia: true,
                debug: true,
                detectSpeakingEvents: true,
                autoAdjustMic: false,
                url: 'http://169.254.95.210:8888'
            });

            // when it's ready, join if we got a room from the URL
            webrtc.on('readyToCall', function () {
                // you can name it anything
                if (room) webrtc.joinRoom(room);
            });
            
            
            
function addToChat(msg, color) {
  var messages = document.getElementById('messages');
  // msg = sanitize(msg);
  if(color) {
    msg = '<span style="color: ' + color + '; padding-left: 15px">' + msg + '</span>';
  } else {
    msg = '<strong style="padding-left: 15px">' + msg + '</strong>';
  }
  messages.innerHTML = messages.innerHTML + msg + '<br>';
  messages.scrollTop = 10000;
}
            
var websocketChat = {
  send: function(message) {
    webrtc.connection.send(message);
  },
  recv: function(message) {
    return message;
  },
  event: 'receive_chat_msg'
};

var dataChannelChat = {
  send: function(message) {
    for(var connection in webrtc.dataChannels) {
      var channel = webrtc.dataChannels[connection];
      channel.send(message);
    }
  },
  recv: function(channel, message) {
    return JSON.parse(message).data;
  },
  event: 'data stream data'
};

function initChat() {
  var chat;

  if(webrtc.dataChannelSupport) {
    console.log('initializing data channel chat');
    chat = dataChannelChat;
  } else {
    console.log('initializing websocket chat');
    chat = websocketChat;
  }

  var input = document.getElementById("chatinput");
  
  var color = "#" + ((1 << 24) * Math.random() | 0).toString(16);

  input.addEventListener('keydown', function(event) {
    var key = event.which || event.keyCode;
    if(key === 13) {
      chat.send(JSON.stringify({
        "eventName": "chat_msg",
        "data": {
          "messages": input.value,
          "room": room,
          "color": color
        }
      }));
      addToChat(input.value);
      input.value = "";
    }
  }, false);
  
  webrtc.on(chat.event, function() {
    var data = chat.recv.apply(this, arguments);
    console.log(data.color);
    addToChat(data.messages, data.color.toString(16));
  });
}
            

            var button = $('#screenShareButton'),
                setButton = function (bool) {
                    button.text(bool ? 'share screen' : 'stop sharing');
                };

            setButton(true);

            button.click(function () {
                if (webrtc.getLocalScreen()) {
                    webrtc.stopScreenShare();
                    setButton(true);
                } else {
                    webrtc.shareScreen(function (err) {
                        if (err) {
                            setButton(true);
                        } else {
                            setButton(false);
                        }
                    });
                    
                }
            });
            
            initChat();
        </script>
    </body>
</html>