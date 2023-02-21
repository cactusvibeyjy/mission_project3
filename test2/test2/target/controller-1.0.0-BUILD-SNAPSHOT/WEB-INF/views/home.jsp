<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous">
	</script>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.3.0/exceljs.min.js"></script>
	<script lang="javascript" src="https://cdn.sheetjs.com/xlsx-0.19.2/package/dist/xlsx.full.min.js"></script>

<title>야호</title>

	<style>
		.pop {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			z-index: 100;
			width: 100%;
			height: 100%;
			background: rgba(0, 0, 0, .5);
		}
		.pop.on{
			display: block;
		}

		.pop .info {
			overflow-y: auto;
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			width: 800px;
			height: 330px;
			max-height: 92%;
			margin: 0 auto;
			background: #fff;
			border-radius: 5px;
			padding: 10px;
		}

		.pop .info table {
			width: 100%;
			border: 1px solid #ddd;
		}

		.pop .info table tr th ,
		.pop .info table tr td {
			height: 50px;
			padding-left: 10px;
			vertical-align: middle;
			border: 1px solid #ddd;
		}

		.pop .info table tr td input[type=text] ,
		.pop .info table tr td select {
			width: 40%;
			height: 40px;
			padding: 0 15px;
			border: 1px solid #ddd;
			border-radius: 3px;
			outline: none;
		}

		.pop .info .bottom {

		}
		.pop .info .bottom .button_area {
			text-align: center;
			margin-top: 10px;
		}

	</style>

</head>
<body>
	<h2></h2>

	<div class="container">
		<div>
			<input type="text" id="memberId" placeholder="아이디" class="form-control" value="" />
			<input type="text" id="memberNm" placeholder="이름" class="form-control" />
		</div>
		<div>
			<input type="date" name="startDate" id="startDate" />
			<input type="date" name="endDate" id="endDate" />
		</div>
		<div class="">
			<input type="radio" name="sex" id="sexM" value="male" onchange="fn_list()" checked />
			<label for="sexM">남성</label>
			<input type="radio" name="sex" id="sexF" value="female" onchange="fn_list()" />
			<label for="sexF">여성</label>
		</div>

		<select name="country" id="country" onchange="Change(this,'city')">
			<option value="none" selected>국가</option>
			<option value="a">한국</option>
			<option value="b">미국</option>
			<option value="c">중국</option>
			<option value="d">일본</option>
		</select> 
		<select id="city">
			<option value="none" selected>도시</option>
		</select>
		<br>
		<div class="button">
			<button class="registerButton clickedButton" onclick="fn_addRow(this)">
				<span>추가</span> <i class="zmdi zmdi-arrow-right"></i>
			</button>
			<button class="registerButton clickedButton" onclick="fn_save('s')">
				<span>저장</span> <i class="zmdi zmdi-arrow-right"></i>
			</button>
			<button class="searchButton clickedButton" onclick="fn_list()">
				<span>조회하기</span> <i class="zmdi zmdi-arrow-right"></i>
			</button>
			<button class="excelButton clickedButton" onclick="fn_excel()">
				<span>엑셀다운</span> <i class="zmdi zmdi-arrow-right"></i>
			</button>
			<button class="deleteButton" onclick="fn_delete()">
				<span>삭제하기</span> <i class="zmdi zmdi-arrow-right"></i>
			</button>
		</div>
	</div>
	<table class="table table-striped">
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
				<td><input type="text" id="mMemberId" /></td>
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
						<option value="a">한국</option>
						<option value="b">미국</option>
						<option value="c">중국</option>
						<option value="d">일본</option>
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


</body>
<script type="text/javascript">
$(function () {

})

var fn_hide = function () {
	$('.pop.on').removeClass('on');
}

var fn_addRow = function () {

    if($('#sMemberId').length > 0) {
        return alert('아직 작업중인 row 가 있습니다.\n작업 완료 후 추가하세요.');
    }

	var addTr = '<tr>';
    addTr += '<td></td>';
    addTr += '<td><input id="sMemberId" /></td>';
    addTr += '<td><input id="sMemberNm" /></td>';
    addTr += '<td>';
    addTr += '  <input type="radio" name="sSex" id="sMale" value="male" checked/><label for="sMale">남</label>';
    addTr += '  <input type="radio" name="sSex" id="sFemale" value="female"/><label for="sFemale">여</label>';
    addTr += '</td>';
    addTr += '<td>';
    addTr += '  <select name="country" id="sCountry" onchange="Change(this,`sCity`)">';
    addTr += '      <option value="none" selected>국가</option>';
    addTr += '      <option value="a">한국</option>';
    addTr += '      <option value="b">미국</option>';
    addTr += '      <option value="c">중국</option>';
    addTr += '      <option value="d">일본</option>';
    addTr += '  </select>';
    addTr += '</td>';
    addTr += '<td>';
    addTr += '  <select id="sCity">';
    addTr += '      <option value="none" selected>도시</option>';
    addTr += '  </select>';
    addTr += '</td>';
    addTr += '</tr>';
    $('#data_tbody').prepend(addTr);

}

// 초기화
var fn_reset = function () {

    $('#memberId , #memberNm , #modifyId').val('');

    // 날짜 오늘날짜로 셋팅
    var date = new Date();
    var month = date.getMonth().toString().length===1 ? '0'+(date.getMonth()+1) : date.getMonth();
    $('input[type=date]').val(date.getFullYear() +'-'+ month + '-' + date.getDate());

    $('#sexM').prop('checked',true);

    $('#country').val('none');
	$('#city').empty().append('<option value="none" selected>도시</option>');
}

// 목록
var fn_list = function () {
    var param = {};
    param.memberId  = $('#memberId').val();
    param.memberNm  = $('#memberNm').val();
    param.startDate = $('#startDate').val().replaceAll('-','');
    param.endDate   = $('#endDate').val().replaceAll('-','');
    param.sex       = $('input[name=sex]:checked').val();
    param.country   = $('#country').val();
    param.city      = $('#city').val();

    $.ajax({
        url	:'/member/list.json',
        type:'POST',
        data:param,
        success: function(res) {

            $('#data_tbody').empty();

            for(var data of res) {
                var html = '<tr>';
                html += '<td><input data-id="'+data.memberId+'" type="checkbox"></td>';
                html += '<td ondblclick="fn_detail(`'+data.memberId+'`)">'+data.memberId+'</td>';
                html += '<td>'+data.memberNm+'</td>';
                html += '<td>'+data.sex+'</td>';
                html += '<td>'+data.country+'</td>';
                html += '<td>'+data.city+'</td>';
                html += '</tr>';
                $('#data_tbody').append(html);
            }

        }
    });
}

// 상세
var fn_detail = function (memberId) {
    $('.pop').addClass('on');

    $.ajax({
        url	:'/member/detail.json',
        type:'POST',
        data:{memberId : memberId},
	    success: function(res) {

            $('#mMemberId').val(res.memberId);
            $('#mMemberNm').val(res.memberNm);

            res.sex === 'male' ? $('#mMale').prop('checked',true) : $('#mFemale').prop('checked',true);

            $('#mCountry').val(res.country).trigger('change');
            $('#mCity').val(res.city);

        }
    });
}

// 저장
var fn_save = function (flag) {

	var param = {};
	param.memberId  = $('#'+flag+'MemberId').val();
	param.memberNm  = $('#'+flag+'MemberNm').val();
    param.country   = $('#'+flag+'Country').val();
    param.city      = $('#'+flag+'City').val();

    var url = 'insert.json';
	if(flag === 'm') {
        param.sex       = $('input[name=mSex]:checked').val();
        param.modifyId  = param.memberId;
        url             = 'update.json';
	} else {
        if($('#sMemberId').length < 1) {
            return alert('[추가]버튼 클릭 후 작업하세요.');
        }
        param.sex       = $('input[name=sSex]:checked').val();
	}

	if(param.memberId === '') {
	    return alert('아이디를 입력해주세요.');
	}
	if(param.memberNm === '') {
	    return alert('이름을 입력해주세요.');
	}
	if(param.country === 'none') {
	    return alert('국가를 선택해주세요.');
	}
	if(param.city === 'none') {
	    return alert('도시를 선택해주세요.');
	}

    $.ajax({
        url	:'/member/'+url,
        type:'POST',
        data:param,
	    success: function(res) {
	        if(res === 1) {
                fn_list();
                if(flag === 'm') {
                    fn_hide()
                }
	            return alert('저장되었습니다.');
	        }
        }
    });
}

// 삭제
var fn_delete = function () {

    var param = {} , memberIdArr = [];

    if($('#data_tbody input[type=checkbox]:checked').length < 1) {
        return alert('삭제 할 데이터를 선택해주세요.');
    }
    $('#data_tbody input[type=checkbox]:checked').each(function(i,t) {
        memberIdArr.push($(t).data('id'));
    })
    param.memberIdArr = memberIdArr;

    $.ajax({
        url	:'/member/delete.json',
        type:'POST',
        data:JSON.stringify(param),
        contentType : 'application/json',
	    success: function(res) {
            if(res > 0) {
                fn_list();
                return alert('삭제 되었습니다.');
            }
        }
    });

}

// 전체선택
var fn_allCheck = function (tag) {
	if($(tag).is(':checked')) {
        $('#data_tbody input[type=checkbox]').prop('checked',true);
	} else {
        $('#data_tbody input[type=checkbox]').prop('checked',false);
	}
}

// 엑셀
var fn_excel = function () {
    var wb = XLSX.utils.table_to_book(document.getElementById('data_tbody'), {sheet:"시트명",raw:true});
    XLSX.writeFile(wb, ('파일명.xlsx'));
}

var Change = function (tag , target) {
	var city_z = [ "none" ];
	var city_a = [ "서울", "부산", "창원", "경주","대구","대전", "통영" ];
	var city_b = [ "NYC", "LA", "Pheonix", "Tucson", "Litiz", "Lafayette" ];
	var city_c = [ "베이징", "상하이", "광저우", "청두", "우한", "톈진" ];
	var city_d = [ "도쿄", "오사카", "삿포로", "교토", "후쿠오카", "고베" ];

	var targetTag = document.getElementById(target);

	var d = '';
	switch (tag.value) {
		case 'a': d = city_a; break;
		case 'b': d = city_b; break;
		case 'c': d = city_c; break;
		case 'd': d = city_d; break;
		default:  d = city_z;
    }
    targetTag.options.length = 0;

	for (var x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
        opt.innerHTML = d.length > 1 ? d[x] : '도시';
        targetTag.appendChild(opt);
	}
}
</script>
</html>
