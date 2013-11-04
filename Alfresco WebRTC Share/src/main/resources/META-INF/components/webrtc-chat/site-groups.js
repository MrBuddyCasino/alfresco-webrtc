/**
 * SiteGroups tool component.
 *
 * @namespace Westernacher
 * @class Westernacher.SiteGroups
 */
(function()
{
   /**
    * YUI Library aliases
    */
   var Dom = YAHOO.util.Dom,
      Event = YAHOO.util.Event,
      Element = YAHOO.util.Element;

   /**
    * Alfresco Slingshot aliases
    */
   var $html = Alfresco.util.encodeHTML;

   if(typeof(Westernacher) == "undefined") { Westernacher = {}; }

   /**
    * ConsoleGroups constructor.
    *
    * @param {String} htmlId The HTML id of the parent element
    * @return {Westernacher.SiteGroups} The new SiteGroups instance
    * @constructor
    */
   Westernacher.WebRTC = function(htmlId)
   {
	   Westernacher.WebRTC.superclass.constructor.call(this, htmlId);
	   var me = this;


   };

   YAHOO.extend(Westernacher.WebRTC, Alfresco.component.Base);

})();