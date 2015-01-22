# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

function getSystemData(sysname){
alert("In get sys data");
//var data = {data: {ver:2}}; //Just one required parameter - Simplest possible
var data = {
  data: {
    ver:2,
    test: true,
    outputmode:1,
    filter:{
        knownstatus:0,
        systemname: sysname
        //,
        //cr:5,
        //date:"2014-09-18 12:34:56",
        //coordcube: [[-1,1],[-1,1],[-1,1]],
        //coordsphere: {radius: 123.45, origin: [10,20,30]}
    }
  }
};

$.ajax({
  type: 'POST',
  contentType: 'application/json; charset=utf-8',
  url: 'api.asmx/GetSystems',
  data: JSON.stringify(data),
  dataType: 'json',
  success:
    function(data){
      submitsuccess(data.d);
    },
  error: submiterror
});
};

function submitsuccess(data){
	alert("Data: " + data);
}

function submiterror(d,a){}
