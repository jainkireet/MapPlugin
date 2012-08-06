function MapPlugin() {}

MapPlugin.prototype.showMap = function()
{
    PhoneGap.exec(null,null,"MapPlugin","showMap",[]);
}

PhoneGap.addConstructor(function () {
  if (typeof window.plugins == 'undefined') window.plugins = {};
  if( typeof window.plugins.MapPlugin == 'undefined' ) window.plugins.MapPlugin = new MapPlugin();
});