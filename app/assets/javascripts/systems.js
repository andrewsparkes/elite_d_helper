//API docs: http://edstarcoordinator.com/api.html

function getSystemName(mySystemName) {
  var query = {
      ver:2,
      test:true,
      outputmode:2,
      filter:{
          knownstatus:1,
          systemname: mySystemName,
          cr:5,
          date:"2014-09-18 12:34:56"
      }
  };

  callEDSapi(query);
}

function callEDSapi(query) {
  var data = { data: query };
  alert("data: " + JSON.stringify(data));
  $.ajax({
    type: 'POST',
    contentType: 'application/json; charset=utf-8',
    url: 'http://edstarcoordinator.com/api.asmx/GetSystems',
    data: JSON.stringify(data),
    dataType: 'json',
    success:
      function (data) {
        submitsuccess(data);
      },
    error: submiterror
  });
};

function submitsuccess(data) {
  $('#edsout').html(syntaxHighlight(removequotes(
      JSON.stringify(data.d, undefined, 2)
  )));
  // console.log(data);
  alert("ret name = " + data.d.systems[0].name + " and x,y,z = " + data.d.systems[0].coord[0] + "," + data.d.systems[0].coord[1] + "," + data.d.systems[0].coord[2])
  // TODO write the eds id and coords into a form to update the system db row
  // or auto-submit them to system update controller method?
}

function submiterror(d, a) {
  $('#edsout').html(d.responseText);
  // console.log(d);
}

//******** Pretty printing *************
function removequotes(json){
  //removes quotes around properties
  return json.replace(/\"([^(\")"]+)\":/g,"$1:")
}


function syntaxHighlight(json) {
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
            } else {
                cls = 'string';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
        } else if (/null/.test(match)) {
            cls = 'null';
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}