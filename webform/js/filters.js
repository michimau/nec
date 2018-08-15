export default angular.module('necdsFilter',[])

.filter('sectorFilter', function() {
  return function(items, sectors) {
    if (!sectors) { return []; }
      var inverseSectorsMap = {
        "ES":"Energy_Supply",
        "EC":"Energy_Consumption",
        "TR":"Transport",
        "IP":"Industrial_Processes",
        "AG": "Agriculture", 
        "LULUCF":"LULUCF", 
        "WA":"Waste",
        "CC":"Cross-cutting"
      };
      var tempArray = [];
      var expression = /^[A-Z]+\_/;
      for(var i=0;i<items.length;i++) {
        var res = items[i].match(expression);
        if (sectors.indexOf(inverseSectorsMap[res[0].slice(0,-1)]) !== -1) { tempArray.push(items[i]); }
      }    
      return tempArray;
  };
})

.filter('individualPAM', function() { 
  return function(items) {
    var tempArray = [];
    for (var i=0;i<items.length;i++) {
      if (items[i].Table1.isGroup === 'single') {
        tempArray.push(items[i]);
      }
    }
    return tempArray;
  };
});