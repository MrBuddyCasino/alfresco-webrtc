
<#assign el=args.htmlid?html>

<script language="JavaScript">
<!--
var iframeUrl = Alfresco.constants.URL_CONTEXT + "service/westernacher/webrtc/chat-iframe?" + Alfresco.constants.SITE;
//-->
</script>

<iframe id="webrtc-chat" onload="autoResize('webrtc-chat');"
 src="/share/service/westernacher/webrtc/chat-iframe?swsdp" 
seamless="true" 
style="width: 100%; height: 800px; overflow: hidden;" />
