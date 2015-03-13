$(function() {

  //https://rubygems.org/gems/jquery-turbolinks
  // try this to solve the reload problem

  var today = Date.create().format("{MM}/{dd}/{yyyy}");
  var default_picker_options = {
    format: 'MM/DD/YYYY',
    minDate: today
  }

  var query_options = {
    city_name: "Brussels",
    city_full_name: "Brussels, BU, Belgium",
    city_id: "3406",
    city_latitude: 50.833000,
    city_longitude: 4.333000,
    country: "Belgium",
    arrival: today,
    depart: "01/01/2016",
    guests: 2,
    extra_tags: ''
  }

  // TODO Try this to repace the current date picker system
  // https://github.com/dangrossman/bootstrap-daterangepicker

  $("#arrival_date_picker").datetimepicker(default_picker_options);
  $("#arrival_date_picker").on("dp.change",function (event) {
    query_options.arrival = event.date;
    $('#depart_date_picker').data("DateTimePicker").minDate(event.date);
  });

  $("#depart_date_picker").datetimepicker(default_picker_options);
  $("#depart_date_picker").on("dp.change",function (event) {
    query_options.depart = event.date;
  });

  $(".selectpicker").selectpicker({
    width: 100
  });
  $(".selectpicker").on("change", function(e) {
    var number_of_guests = $(".selectpicker").val();
    query_options.guests = number_of_guests;
  });

  $("#btn-search").on("click", function(event)  {
    event.preventDefault();
    query_options.extra_tags = JSON.stringify(create_extra_query_params());
    var params =  jQuery.param(query_options);
    var path = '/hotels?' + params;
    document.location.href = path;
  });

  $("#btn-save").on("click", function(event)  {
    event.preventDefault();
    query_options.extra_tags = JSON.stringify(create_extra_query_params());
    var params =  jQuery.param(query_options);
    var path = '/profile/add_new_hotel_style?' + params;
    document.location.href = path;
  });

  //http://davidstutz.github.io/bootstrap-multiselect/
  // https://github.com/Serhioromano/bootstrap-tags#install

  $("#ambiances_select").multiselect({
    buttonWidth: 200,
    maxHeight: 200,
    nonSelectedText: 'Select ambiances ...',
    onChange: function(option, checked, select) {
      var id_val = "amb-" + $(option).val();
      var text_val = $(option).text();
      if (checked) {
        $('#tag-box').tagsinput('add', { id: id_val, value: text_val });
      } else {
        $('#tag-box').tagsinput('remove', { id: id_val, value: text_val });
      }
    }
  });
  $("#facilities_select").multiselect({
    buttonWidth: 200,
    maxHeight: 200,
    nonSelectedText: 'Select facilities ...',
    onChange: function(option, checked, select) {
      var id_val = "fac-" + $(option).val();
      var text_val = $(option).text();
      if (checked) {
        $('#tag-box').tagsinput('add', { id: id_val, value: text_val });
      } else {
        $('#tag-box').tagsinput('remove', { id: id_val, value: text_val });
      }
    }
  });

  $("#location_select").select2({
    width: 180,
    plpaceholder: "Location",
    minimumInputLength: 3,
    ajax: {
      url: "http://gd.geobytes.com/AutoCompleteCity?",
      dataType: 'jsonp',
      placeholder: 'Select your city',
      delay: 250,
      data: function (params) {
        return {
          q: params
        };
      },
      results: function (data) {
        var items = [];
        $.each(data, function(index, item) {
          items.push({ text: item, id: index } );
        });
        return {
          results: items
        };
      },
      cache: true,
      formatResult: function (item) {
        var markup = "";
        if (item !== undefined) {
          markup += "<option >" + item + "</option>";
        }
        return markup;
      },
      id: function(e) {
        return e.id;
      }
    }
  });

  $("#location_select").on("select2-selecting", function (event) {
    if (event) {
      query_options.city_full_name  = event.object.text
      ajaxUrl = 'http://gd.geobytes.com/GetCityDetails?fqcn=' + query_options.city_full_name
      $.ajax({
        type: "GET",
        url: ajaxUrl,
        dataType: "jsonp",
        processdata: true,
        success: function (data) {
          if (data) {
            query_options.city_name = data.geobytescity;
            query_options.city_id = data.geobytescityid;
            query_options.city_latitude = data.geobyteslatitude;
            query_options.city_longitude = data.geobyteslongitude;
            query_options.city_full_name = data.geobytesfqcn;
            query_options.country = data.geobytescountry;
            var id_val = "loc-" + query_options.city_id;
            var text_val = query_options.city_name;
            $('#tag-box').tagsinput('add', { id: id_val, value: text_val });
          }
        },
        error: function(error) {
          console.log(error.responseText);
        }
      });
    }
  });

  $('#advanced-lnk').click(function() {
    secondary_panel_visible = $('.search-box-secondary').is(":visible");
    if (secondary_panel_visible) {
      $('.search-box-secondary').hide();
      $(this).html("<i class='fa fa-plus'></i>");
    } else {
      $('.search-box-secondary').show();
      $(this).html("<i class='fa fa-minus'></i>");
    }
    event.preventDefault();
  });
  $('.search-box-secondary').hide();

  $('#tag-box').tagsinput({
    itemValue: 'id',
    itemText: 'value'
  });
  $('#tag-box').on('itemRemoved', function(event) {
    var item = event.item;
    var id = item.id.split('-');
    var param_id = id[1];
    var param_value = item.value;
    if (id[0] === 'amb') {
      $("#ambiances_select").multiselect('deselect', param_id);
    } else if (id[0] === 'fac') {
      $("#facilities_select").multiselect('deselect', param_id);
    } else if (id[0] === 'pri') {
      $("#prices_select").multiselect('deselect', param_id);
    } else if (id[0] === 'fac') {
      $("#facilities_select").multiselect('deselect', param_id);
    } else if (id[0] === 'loc') {
      $("#location_select").select2("val", "");
    }
    var tags = $('#tag-box').tagsinput('items');
    if (tags.length === 0) {
      $('#tag-box-result').hide();
      $('#tag-box-div').hide();
      $('#btn-save').hide();
    }
    var results = get_number_of_hotels();
    result_span = $('.result-size')
    if (result_span) {
      result_span.text(results);
    }
  });

  $('#tag-box').on('itemAdded', function(event) {
    var item = event.item;
    var tags = $('#tag-box').tagsinput('items');
    if (tags.length === 1) {
      $('#tag-box-result').show();
      $('#tag-box-div').show();
      $('#btn-save').show();
    }
    var results = get_number_of_hotels();
    result_span = $('.result-size')
    if (result_span) {
      result_span.text(results);
    }
  });
  $('#tag-box-result').hide();
  $('#tag-box-div').hide();
  var btn_save = $('#btn-save');
  if (typeof(btn_save) != 'undefined') {
    btn_save.hide();
  }

  $("#prices_select").multiselect({
    buttonWidth: 156,
    maxHeight: 200,
    nonSelectedText: 'Price...',
    onChange: function(option, checked, select) {
      var id_val = "pri-" + $(option).val();
      var text_val = $(option).text();
      if (checked) {
        $('#tag-box').tagsinput('add', { id: id_val, value: text_val });
      } else {
        $('#tag-box').tagsinput('remove', { id: id_val, value: text_val });
      }
    }
  });

  function create_extra_query_params() {
    var tags = $('#tag-box').tagsinput('items');
    var extra_tags = [];
    var i = 0;
    for (i; i < tags.length; i++) {
      var id_val = tags[i].id;
      var value_val = tags[i].value;
      extra_tags.push({ id: id_val, value: value_val })
    }
    return extra_tags;
  }

  function get_number_of_hotels() {
    var tags = $('#tag-box').tagsinput('items');
    var number_of_tags = tags.length;
    var hotels = 0
    if (number_of_tags < 8) {
      var max = 500 * number_of_tags;
      var min = 100 * number_of_tags;
      hotels = 3000 - (Math.random() * (max - min));
    }
    return Math.round(hotels);
  }

  if (typeof(query_params) !== undefined && query_params != null) {
    var i = 0;
    for (i; i < query_params.length; i++) {
      var tag = query_params[i];
      var tag_id = tag.id;
      var tag_value = tag.value
      $('#tag-box').tagsinput('add', { id: tag_id, value: tag_value });
      if (tag_id.startsWith('amb-')) {
        tag_id = tag_id.substring(4);
        $("#ambiances_select").multiselect('select', tag_id);
      } else if (tag_id.startsWith('fac-')) {
        tag_id = tag_id.substring(4);
        $("#facilities_select").multiselect('select', tag_id);
      } else if (tag_id.startsWith('pri-')) {
        tag_id = tag_id.substring(4);
        $("#prices_select").multiselect('select', tag_id);
      }
    }
  }
});

