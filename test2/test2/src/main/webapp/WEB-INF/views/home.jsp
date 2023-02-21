<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>
	<meta charset="utf-8">
  <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
      crossorigin="anonymous">
  <link href="/css/styles.css" rel="stylesheet">
  <link href="/js/jquery-sumoselect/sumoselect.min.css" rel="stylesheet">


  <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
      crossorigin="anonymous">
  </script>
  <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="/js/jquery-sumoselect/jquery.sumoselect.min.js"></script>

  <script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.3.0/exceljs.min.js"></script>
  <script lang="javascript" src="https://cdn.sheetjs.com/xlsx-0.19.2/package/dist/xlsx.full.min.js"></script>


  <style type="text/css">
  .SumoSelect .select-all{
	  height: 40px;
	}
  </style>
  <title>야호</title>

</head>
<body>
  <h2></h2>

  <div class="container" style="margin-top: 80px">
    <div>
      <input type="text" id="memberId" placeholder="아이디" class="form-control" onfocusout="fn_dupCheck(this)" value="" style="width: 200px; margin-bottom:10px" />
      <input type="text" id="memberNm" placeholder="이름" class="form-control" style="width: 200px; margin-bottom:10px" />
    </div>
    <div class="daterange" style="margin-top: 25px">
      <input type="date" name="startDate" id="startDate" />
      <input type="date" name="endDate" id="endDate" />
    </div>
    <div class="sex" style="margin-top:10px; margin-bottom:10px;">
      <input type="radio" name="sex" id="sexM" value="male" onchange="fn_list()" />
      <label for="sexM">남성</label>
      <input type="radio" name="sex" id="sexF" value="female" onchange="fn_list()" />
      <label for="sexF">여성</label>
    </div>

    <select name="country" id="country" onchange="changeCountry(this.value,'city')">
      <option value="none" selected>국가</option>
      <option value="한국">한국</option>
      <option value="미국">미국</option>
      <option value="중국">중국</option>
      <option value="일본">일본</option>
    </select>
    <select id="city">
      <option value="none" selected>도시</option>
    </select>
    <br>
    <div class="button" style="margin-top:10px; border-radius: 20px;">
      <button class="registerButton clickedButton" onclick="fn_addRow(this)" style="border-radius: 10px;">
        <span>추가하기</span> <i class="zmdi zmdi-arrow-right"></i>
      </button>
      <button class="registerButton clickedButton" onclick="fn_save('s')" style="border-radius: 10px;">
        <span>저장하기</span> <i class="zmdi zmdi-arrow-right"></i>
      </button>
      <button class="searchButton clickedButton" onclick="fn_list()" style="border-radius: 10px;">
        <span>조회하기</span> <i class="zmdi zmdi-arrow-right"></i>
      </button>
      <button class="excelButton clickedButton" onclick="fn_excel()" style="border-radius: 10px;">
        <span>엑셀다운</span> <i class="zmdi zmdi-arrow-right"></i>
      </button>
      <button class="deleteButton" onclick="fn_delete()" style="border-radius: 10px;">
        <span>삭제하기</span> <i class="zmdi zmdi-arrow-right"></i>
      </button>
    </div>
  </div>
  <div class="list" style="margin: 50px 80px 50px 50px;">
    <table class="table table-fixed" style="border: 3px;" id="members">
      <thead>
        <tr>
          <th scope="col">
            <input type="checkbox" id="allCheck" onchange="fn_allCheck(this)" />
            <label for="allCheck">선택</label>
          </th>
          <th scope="col">아이디</th>
          <th scope="col">이름</th>
          <th scope="col">성별</th>
          <th scope="col">국가</th>
          <th scope="col">도시</th>
        </tr>
      </thead>
      <tbody id="data_tbody">

      </tbody>
    </table>
    <input type="hidden" id="modifyId" />
  </div>
  <!-- 팝업 기능 주석 -->
  <!--
<div class="pop">
  <div class="info">

    <table>
      <colgroup>
        <col style="width: 20%;">
        <col style="width: 80%;">
      </colgroup>
      <tbody>
      <tr>
        <th>아이디</th>
        <td><input type="text" id="mMemberId" onfocusout="fn_dupCheck(this)" /></td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" id="mMemberNm" /></td>
      </tr>
      <tr>
        <th>성별</th>
        <td>
          <input type="radio" name="mSex" id="mMale" value="male" />
          <label for="mMale">남</label>
          <input type="radio" name="mSex" id="mFemale" value="female" />
          <label for="mFemale">여</label>
        </td>
      </tr>
      <tr>
        <th>국가</th>
        <td>
          <select id="mCountry" onchange="Change(this,`mCity`)">
            <option value="none" selected>국가</option>
            <option value="한국">한국</option>
            <option value="미국">미국</option>
            <option value="중국">중국</option>
            <option value="일본">일본</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>도시</th>
        <td>
          <select id="mCity"></select>
        </td>
      </tr>
      </tbody>
    </table>

    <div class="bottom">
      <div class="button_area">
        <button type="button" onclick="fn_save('m')">저장</button>
        <button type="button" onclick="fn_hide()">닫기</button>
      </div>
    </div>
  </div>
</div>
 -->

</body>
<script type="text/javascript">
$(function() {

})

let newRowNum = 0;

var fn_dupCheck = function(tag) {

  if ($(tag).val() != "") {
    $.ajax({
      url: '/member/dupCheck.json',
      type: 'POST',
      data: {
        memberId: $(tag).val()
      },
      success: function(res) {
        if (res > 0) {
          return alert("아이디가 중복됩니다.");
        }

      }
    });
  }

}

var fn_hide = function() {
  $('.pop.on').removeClass('on');
}

var fn_addRow = function() {

  /* if($('#sMemberId').length > 0) {
      return alert('아직 작업중인 row 가 있습니다.\n작업 완료 후 추가하세요.');
  } */
  newRowNum++;

  var addTr = '<tr class="newRowNum table-active" id="newRowNum' + newRowNum + '">';
  addTr += '<td></td>';
  addTr += '<td><input id="sMemberId" name="sMemberId' + newRowNum + '" onfocusout="fn_dupCheck(this)" /></td>';
  addTr += '<td><input id="sMemberNm" name="sMemberNm' + newRowNum + '" /></td>';
  addTr += '<td>';
  addTr += '  <input type="radio" name="sSex' + newRowNum + '" id="sMale" value="male" checked onchange="sexChange(this)"/><label for="sMale">남</label>';
  addTr += '  <input type="radio" name="sSex' + newRowNum + '" id="sFemale" value="female" onchange="sexChange(this)"/><label for="sFemale">여</label>';
  addTr += '</td>';
  addTr += '<td>';
  addTr += '  <select name="aCountry' + newRowNum + '" id="aCountry" onchange="changeCountry(this.value, \'aCity' + newRowNum + '\')">';
  addTr += '      <option value="none" selected>국가</option>';
  addTr += '      <option value="한국">한국</option>';
  addTr += '      <option value="미국">미국</option>';
  addTr += '      <option value="중국">중국</option>';
  addTr += '      <option value="일본">일본</option>';
  addTr += '  </select>';
  addTr += '</td>';
  addTr += '<td>';
  addTr += '  <select name="aCity' + newRowNum + '" id="aCity' + newRowNum + '" multiple>';
  addTr += '      <option value="none" selected>도시</option>';
  addTr += '  </select>';
  addTr += '</td>';
  addTr += '</tr>';
  $('#data_tbody').prepend(addTr);

  $('#aCity' + newRowNum).SumoSelect({ selectAll: true, locale :  ['OK', 'Cancel', '전체'] });
}

// 초기화
var fn_reset = function() {

  $('#memberId , #memberNm , #modifyId').val('');

  // 날짜 오늘날짜로 셋팅
  var date = new Date();
  var month = date.getMonth().toString().length === 1 ? '0' + (date.getMonth() + 1) : date.getMonth();
  $('input[type=date]').val(date.getFullYear() + '-' + month + '-' + date.getDate());

  $('#sexM').prop('checked', true);

  $('#country').val('none');
  $('#city').empty().append('<option value="none" selected>도시</option>');
}

// 목록
var fn_list = function() {
  var param = {};
  param.memberId = $('#memberId').val();
  param.memberNm = $('#memberNm').val();
  param.startDate = $('#startDate').val().replaceAll('-', '');
  param.endDate = $('#endDate').val().replaceAll('-', '');
  param.sex = $('input[name=sex]:checked').val();
  param.country = $('#country').val();
  param.city = $('#city').val();

  $.ajax({
    url: '/member/list.json',
    type: 'POST',
    data: param,
    success: function(res) {
      $('#data_tbody').empty();

      for (var data of res) {
        var html = '';
        if (data.sex == 'male') {
          html += "<tr class='table-active' ondblclick='editRow(this)'>";
        } else {
          html += "<tr onclick='editRow(this)''>";
        }
        html += '<td><input data-id="' + data.memberId + '" type="checkbox"></td>';
        html += '<td>' + data.memberId + '</td>';
        html += '<td>' + data.memberNm + '</td>';
        html += '<td>' + data.sex + '</td>';
        html += '<td>' + data.country + '</td>';
        html += '<td>' + data.city + '</td>';
        html += '</tr>';
        $('#data_tbody').append(html);
      }
      paging();
    }
  });
}

// 상세
var fn_detail = function(memberId) {
  $('.pop').addClass('on');
  $('#modifyId').val(memberId);

  $.ajax({
    url: '/member/detail.json',
    type: 'POST',
    data: {
      memberId: memberId
    },
    success: function(res) {

      $('#mMemberId').val(res.memberId);
      $('#mMemberNm').val(res.memberNm);

      res.sex === 'male' ? $('#mMale').prop('checked', true) : $('#mFemale').prop('checked', true);

      $('#mCountry').val(res.country).trigger('change');
      $('#mCity').val(res.city);

    }
  });
}

//저장
var fn_save = function(flag) {

  let items = $('table').find('.newRowNum');
  let addItems = [];
  let check = true;

  items.each(function(i, item) {
    let addItem = {};
    addItem.memberId = $(item).find('#sMemberId').val();
    addItem.memberNm = $(item).find('#sMemberNm').val();
    addItem.country = $(item).find('#aCountry').val();
    addItem.city = $(item).find("[id^='aCity']").val() + "";
    if ($(item).find('#sMale').is(":checked")) {
      addItem.sex = 'male';
    } else {
      addItem.sex = 'female';
    }

    if (addItem.memberId === '') {
      alert('아이디를 입력해주세요.');
      check = false;
      return false;
    }
    if (addItem.memberNm === '') {
      alert('이름을 입력해주세요.');
      check = false;
      return false;
    }
    if (addItem.country === 'none') {
      alert('국가를 선택해주세요.');
      check = false;
      return false;
    }
    if (addItem.city === 'none') {
      alert('도시를 선택해주세요.');
      check = false;
      return false;
    }

    addItems.push(addItem);

  });

  let editTableitems = $('table').find('.editRow');
  let editItems = [];

  editTableitems.each(function(i, item) {
    let editItem = {};
    editItem.memberId = $(item).find('#sMemberId').val();
    editItem.modifyId = $(item).find('#sModifyId').val();
    editItem.memberNm = $(item).find('#sMemberNm').val();
    if ($(item).find('#sMale').is(":checked")) {
      editItem.sex = 'male';
    } else {
      editItem.sex = 'female';
    }
    editItem.country = $(item).find('#sCountry').val();
    editItem.city = $(item).find("[id^='sCity']").val() + "";
    console.log("editItem.city", editItem.city);
    if (editItem.modifyId === '') {
      alert('아이디를 입력해주세요.');
      check = false;
      return false;
    }
    if (editItem.memberNm === '') {
      alert('이름을 입력해주세요.');
      check = false;
      return false;
    }
    if (editItem.country === 'none') {
      alert('국가를 선택해주세요.');
      check = false;
      return false;
    }
    if (editItem.city === 'none') {
      alert('도시를 선택해주세요.');
      check = false;
      return false;
    }

    editItems.push(editItem);
  });

  if (check) {

  	if(addItems.length > 0){
	    $.ajax({
	      url: '/member/insert.json',
	      type: 'POST',
	      data: {
	        params: addItems
	      },
	      data: JSON.stringify(addItems),
	      contentType: 'application/json',
	      success: function(res) {
	        if (res >= 1) {
	        	fn_hide();
	          fn_list();
	          if(editItems.length == 0){
	          	alert("저장하였습니다.");
	          }
	        }
	      }
	    });
  	}

  	if(editItems.length > 0){
	    $.ajax({
	      url: '/member/update.json',
	      type: 'POST',
	      data: {
	        params: editItems
	      },
	      data: JSON.stringify(editItems),
	      contentType: 'application/json',
	      success: function(res) {
	        if (res >= 1) {
	        	fn_hide();
	          fn_list();
	          alert("저장하였습니다.");
	        }
	      }
	    });
  	}
  }
}


// 삭제
var fn_delete = function() {

  var param = {},
    memberIdArr = [];

  if ($('#data_tbody input[type=checkbox]:checked').length < 1) {
    return alert('삭제 할 데이터를 선택해주세요.');
  }
  $('#data_tbody input[type=checkbox]:checked').each(function(i, t) {
    memberIdArr.push($(t).data('id'));
  })
  param.memberIdArr = memberIdArr;

  $.ajax({
    url: '/member/delete.json',
    type: 'POST',
    data: JSON.stringify(param),
    contentType: 'application/json',
    success: function(res) {
      if (res > 0) {
        fn_list();
        return alert('삭제 되었습니다.');
      }
    }
  });

}

// 전체선택
var fn_allCheck = function(tag) {
  if ($(tag).is(':checked')) {
    $('#data_tbody input[type=checkbox]').prop('checked', true);
  } else {
    $('#data_tbody input[type=checkbox]').prop('checked', false);
  }
}

// 엑셀
var fn_excel = function() {
  var wb = XLSX.utils.table_to_book(document.getElementById('data_tbody'), {
    sheet: "시트명",
    raw: true
  });
  XLSX.writeFile(wb, ('파일명.xlsx'));
}

// 국가 수정 시
function changeCountry(contryName, countryId) {
  $('#sCity1').empty();
  var citys = [];
  citys.z = ["none"];
  citys.a = ["서울", "부산", "창원", "경주", "대구", "대전", "통영", "대전", "여수", "전주", "강릉", "속초", "성남", "수원", "용인"];
  citys.b = ["NYC", "LA", "Pheonix", "Tucson", "Litiz", "Lafayette", "Irvine", "Long Beach", "San Jose", "Seattle", "Denver"];
  citys.c = ["베이징", "상하이", "광저우", "청두", "우한", "톈진"];
  citys.d = ["도쿄", "오사카", "삿포로", "교토", "후쿠오카", "고베"];

  var d = '';
  switch (contryName) {
    case '한국':
      d = citys.a;
      break;
    case '미국':
      d = citys.b;
      break;
    case '중국':
      d = citys.c;
      break;
    case '일본':
      d = citys.d;
      break;
    default:
      d = citys.z;
  }

  var targetTag = document.getElementById(countryId);
  targetTag.innerHTML = "";

  for (var x in d) {
    var opt = document.createElement("option");
    opt.value = d[x];
    opt.innerHTML = d.length > 1 ? d[x] : '도시';
    opt.class = "select";
    targetTag.appendChild(opt);
  }
  if (countryId !== "city") {
    $('#' + countryId).SumoSelect({ selectAll: true, locale :  ['OK', 'Cancel', '전체'] }).sumo.reload();
  }

}

//성별 변경
function sexChange(obj) {
  if (obj.value == 'male') {
    obj.parentNode.parentNode.classList.add('table-active');
  } else {
    obj.parentNode.parentNode.classList.remove('table-active');
  }
}

//row 수정
function editRow(obj) {
  if ($(obj).hasClass("editRow") === false) {
    $(obj).addClass('editRow');

    let length = $(obj).find('td').length

    let trNum = $(obj).closest('tr').prevAll().length;

    let tempMemberId = $(obj).find('td:eq(1)').text();
    $(obj).find('td:eq(1)').empty();
    $(obj).find('td:eq(1)').append('<input id="sMemberId" value=' + tempMemberId + ' style="display:none"/><input id="sModifyId" onfocusout="fn_dupCheck(this)" value=' + tempMemberId + '>');

    let tempMemberNm = $(obj).find('td:eq(2)').text();
    $(obj).find('td:eq(2)').empty();
    $(obj).find('td:eq(2)').append('<input id="sMemberNm" value=' + tempMemberNm + '>');

    let tempMemberSex = $(obj).find('td:eq(3)').text();
    $(obj).find('td:eq(3)').empty();
    if (tempMemberSex == 'male') {
      $(obj).find('td:eq(3)').append('<input type="radio" name="editSex' + trNum + '" id="sMale" value="male" checked onchange="sexChange(this)"/><label for="sMale">남</label><input type="radio" name="editSex' + trNum + '" id="sFemale" value="female" onchange="sexChange(this)"/><label for="sFemale">여</label>');
    } else {
      $(obj).find('td:eq(3)').append('<input type="radio" name="editSex' + trNum + '" id="sMale" value="male"  onchange="sexChange(this)"/><label for="sMale">남</label><input type="radio" name="editSex' + trNum + '" id="sFemale" value="female" checked onchange="sexChange(this)"/><label for="sFemale">여</label>');
    }

    let tempCountry = $(obj).find('td:eq(4)').text();
    $(obj).find('td:eq(4)').empty();
    let conuntryHtml = '  <select name="sCountry' + trNum + '" id="sCountry" onchange="changeCountry(this.value, \'sCity' + trNum + '\')">';
    conuntryHtml += '      <option value="한국">한국</option>';
    conuntryHtml += '      <option value="미국">미국</option>';
    conuntryHtml += '      <option value="중국">중국</option>';
    conuntryHtml += '      <option value="일본">일본</option>';
    conuntryHtml += '  </select>';
    conuntryHtml += '</td>';
    $(obj).find('td:eq(4)').append(conuntryHtml);
    $('select[name=sCountry' + trNum + ']').val(tempCountry);

    let tempCity = $(obj).find('td:eq(5)').text();
    $(obj).find('td:eq(5)').empty();
    let cityHtml = '  <select name="sCity' + trNum + '" id="sCity' + trNum + '" multiple>';
    cityHtml += '      <option value="none" selected>도시</option>';
    cityHtml += '  </select>';
    $(obj).find('td:eq(5)').append(cityHtml);
    $('#sCity' + trNum).SumoSelect({ selectAll: true, locale :  ['OK', 'Cancel', '전체'] });
    changeCountry(tempCountry, 'sCity' + trNum);
    const tempCitys = tempCity.split(",")
    $.each(tempCitys, function(i, item) {
      $('#sCity' + trNum)[0].sumo.selectItem(item);
    });
  }
}

//페이징
function paging() {
  var rowPerPage = 20;
  $('#nav').remove();
  var $members = $('#members');
  $members.after('<div id="nav" style="margin: auto;">');

  var $tr = $($members).find('tbody tr');
  var rowTotals = $tr.length;

  var pageTotal = Math.ceil(rowTotals / rowPerPage);
  var i = 0;

  for (; i < pageTotal; i++) {
    $('<a href="#"></a>').attr('rel', i).html(i + 1).appendTo('#nav');
  }

  $tr.addClass('off-screen').slice(0, rowPerPage).removeClass('off-screen');

  var $pagingLink = $('#nav a');

  $pagingLink.on('click', function(evt) {
    evt.preventDefault();
    var $this = $(this);

    if ($this.hasClass('active')) {
      return;
    }

    $pagingLink.removeClass('active');
    $this.addClass('active');

    var currPage = $this.attr('rel');
    var startItem = currPage * rowPerPage;
    var endItem = startItem + rowPerPage;

    $tr.css('opacity', '0.0').addClass('off-screen').slice(startItem, endItem).removeClass('off-screen').animate({
      opacity: 1
    }, 300);

  });

  $pagingLink.filter(':first').addClass('active');

};
</script>
</html>
