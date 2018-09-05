<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=PmNgQawFPTLSC4A8I3lT&submodules=geocoder"></script>
		<style>
			#area div{cursor: default; }
            .regist { position: relative; width: 1200px; }  
            .sec_content { position: relative; }
            
            .div_info { position: relative; margin-top: 50px; width: 1100px; height: 190px; }
            .title { position: relative; float: left; width: 550px; height: 30px; font-size: 30px; }          
            .intro { position: relative; float: left; margin-top: 50px; width: 1080px; height: 30px; line-height: 30px; border: 1px solid #7E7E7E; }
            .cate{ position: relative; float: left; margin-top: 10px; width: 270px; height: 30px; line-height: 30px; text-align: center; border: 1px solid #7E7E7E; }
            .sel_btn { position: relative; float: left; margin-top: 10px; margin-right: 5px; width: 162px; height: 30px; background-color: #262626; color: white; border: 0; cursor: default;}
            .btn { position: relative; float: left; margin-top: 10px; margin-right: 5px; width: 120px; height: 30px; background-color: #F04768; color: white; border: 0; cursor: pointer;}
            
            .div_locate { position: relative; margin-top: 50px; width: 1100px; height: 420px; }
            .address { position: relative; margin-top: 50px; width: 1100px; height: 30px; border: 1px solid #7E7E7E; cursor: default;}
            .place { position: relative; margin-top: 10px; width: 400px; height: 300px; border: 1px solid #7E7E7E; }
            
            .div_guide {position: relative; margin-top: 50px; width: 1100px; }
            .div_attention { position: relative; margin-top: 50px; width: 1100px; }
            .content { position: relative; margin-top: 50px; width: 1100px; height: 200px; border: 1px solid #7E7E7E; resize: none;cursor: default;}
            #homepage{margin-top : 10px; width:1090px;cursor: default;}
		</style>
</head>
<body>
<div class="regist">
            <div class="sec_content">
                <div class="div_info">
                    <div class="title"><strong id="title"></strong></div>
                    
                    <div id="intro" class="intro">없음</div>
                    
                    <div id="categoly" class="cate"></div>
                    <div id="loc_short" class="cate"></div>
                    <div id="phone" class="cate"></div>
                    <div id="place_id" class="cate"></div>
                    <input id="homepage" type="text" value="홈페이지 없음" readonly/>
                    <input class="sel_btn" id="date" type="date"/>
                    <select class="sel_btn" id="starttime"><option>시작시간</option></select>
                    <select class="sel_btn" id="endtime"><option>끝시간</option></select>
                    <select class="sel_btn" id="people">
                    <option>인원</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6명 이상</option>
                    </select>
                    <input class="sel_btn" id="cash" type="text" value="요금" readonly/>
                    <button class="btn" id="book">예약하기</button>
                    <button class="btn" id="like">찜하기</button><br/>
                </div>
                
                <div class="div_locate">
                    <div class="title"><strong>위치</strong></div>
                    <input id="loc" class="address" type="text" readonly/><br/>
                    <div id="map" class="place"></div><br/><br/><br/><br/>
                </div>
                    
                <div class="div_guide">
                    <div class="title"><strong>시설안내</strong></div>
                    <textarea id="guide" class="content" readonly></textarea>
                </div>
                
                <div class="div_attention">
                    <div class="title"><strong>주의사항</strong></div>
                    <textarea id="attention" class="content" readonly>없음</textarea>
                </div>
                
                <br/><br/>
            </div>
        </div>
</body>
<script>
var array_loc=[];
var array_start=[];
var array_start2=[];
var array_end=[];
var array_end2=[];
var starttime=[];
var endtime=[];
var place_no="${param.place_no}";
var id ="${sessionScope.loginId}";
var cash=0;	

	//예약하기
	$("#book").click(function() {
		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = today.getMonth()+1;
		var dd = today.getDate();
		if(dd<10) {
		    dd='0'+dd
		} 
		if(mm<10) {
		    mm='0'+mm
		} 
		today = yyyy+"-"+mm+"-"+dd;
		
		var sTime = $("#starttime").val().split(":");
		var eTime = $("#endtime").val().split(":");
		var ssTime = parseInt(sTime);
		var eeTime = parseInt(eTime);
		
		if($("#date").val()==""){
			alert("날짜 선택");
		}else if($("#date").val() < today){
			alert("날짜를 다시 선택해주세요.");
		}else if($("#people").val()=="인원"){
			alert("인원을 선택해주세요.");
		}else if(ssTime >= eeTime){
			alert("예약시간을 다시 선택해주세요.");
		}else{
			$.ajax({
	    		type:"post",
				url:"./bookWrite",
				dataType:"JSON",
				data:{
					place_no : place_no,
					date : $("#date").val(),
					startTime : $("#starttime").val(),
					endTime : $("#endtime").val(),
					custom : $("#people").val(),
					price : $("#cash").val()
				},
				success : function(data){
					console.log(data);
					if(data.login == false){
						alert("로그인 후 사용");
					}else if(data.login == true){
						if(data.success > 0){
							alert("예약 완료");
							console.log(data.success);
							location.href="./bookInfo?book_no="+data.success;
							//location.href="book.jsp";
						}else{
							alert("예약 실패");
						}
					}
				},
				error:function(e){
					console.log(e);
				}
	    	});   
		}
	});

    $("#like").click(function(){
    	//console.log(id);
        if($("#like").html()=="찜하기"){
		        $.ajax({
		    		type:"post",
					url:"./like",
					dataType:"JSON",
					data:{
						place_no:place_no,
						id:id
					},
					success : function(data){
						//console.log(data);
						if(data.success==true){
							$("#like").html("찜취소");
							alert("찜이 되었습니다");
						}else{
							alert("찜이 안되었습니다");
						}				
					},
					error:function(e){
						console.log(e);
					}
		    	})   
        }else if($("#like").html()=="찜취소"){
        	$.ajax({
        		type:"post",
    			url:"./detaillikedel",
    			dataType:"JSON",
    			data:{
    				place_no:place_no,
    				id:id
    			},
    			success : function(data){
    				//console.log(data);
    				if(data.success==true){
    					$("#like").html("찜하기");
    					alert("찜이 취소되었습니다");
    				}else{
    					alert("찜이 취소가 안되었습니다");
    				}				
    			},
    			error:function(e){
    				console.log(e);
    			}
        	})
        }
    });
    $(document).ready(function(){ 
    	
    	$.ajax({
			type:"post",
			url:"./placeDetail",
			dataType:"JSON",
			data:{
				place_no:place_no
			},
			success : function(data){
				array_start=data.dto.place_start.split(" ");
				array_start2=array_start[1].split(":");
				var starttime=parseInt(array_start2[0]);
				array_end=data.dto.place_end.split(" ");
				array_end2=array_end[1].split(":");
				var endtime=parseInt(array_end2[0]);
				array_loc=data.dto.place_loc.split("/");
				
				showMap();
				
				
				$("#title").text(data.dto.place_name);
				$("#place_id").html("등록자 : "+data.dto.info_id);
				$("#intro").html(data.dto.place_info);
				$("#categoly").html(data.dto.place_category);
				$("#loc_short").html(array_loc[1]);
				$("#phone").html(data.dto.place_phone);
				$("#homepage").val(data.dto.place_home);
				$("#loc").val("("+array_loc[0]+")"+array_loc[1]+" "+array_loc[2]);
				$("#guide").val(data.dto.place_guide);
				$("#attention").val(data.dto.place_attention);
				$("#cash").val(data.dto.place_price);
				cash=data.dto.place_price;
				 $("#starttime").empty();
				$("#endtime").empty();
				var sta = "";					
				for(var i=0;i<(endtime-starttime);i++){
					sta += "<option>"+(starttime+i)+":00</option>";
				}
				var en ="";
				for(var i=1;i<=(endtime-starttime);i++){
					en += "<option>"+(starttime+i)+":00</option>";
				}
				$("#starttime").append(sta);
				$("#endtime").append(en);
			},
			error:function(e){
				console.log(e);
			}
		});
    	$.ajax({
    		type:"post",
			url:"./detaillike",
			dataType:"JSON",
			data:{
				place_no:place_no,
				id:id
			},
			success : function(data){
				console.log(data);
				if(data.success==true){
					$("#like").html("찜취소");
					//alert("찜을 한 페이지 입니다");					
				}else{
					$("#like").html("찜하기");
					//alert("찜이 안되어있습니다");
				}				
			},
			error:function(e){
				console.log(e);
			}
    	});
    });
    $("#starttime").change(function(e){
    	//console.log($("#endtime").val());
		var start =$("#starttime").val();
		starttime=start.split(":");
		var end=$("#endtime").val();
		var endtime=[];
		endtime=end.split(":");
		//console.log(endtime[0]-starttime[0]);	
		//console.log((endtime[0]-starttime[0])*cash);
		var cashed =(endtime[0]-starttime[0])*cash;
		/* console.log(cashed.indexOf('7')); */
		$("#cash").val(cashed);
	 })
    $("#endtime").change(function(){
    	//console.log($("#endtime").val());
		var start =$("#starttime").val();
		starttime=start.split(":");
		var end=$("#endtime").val();
		var endtime=[];
		endtime=end.split(":");
		//console.log(endtime[0]-starttime[0]);	
		//console.log((endtime[0]-starttime[0])*cash);
		var cashed =(endtime[0]-starttime[0])*cash;
		/* console.log(cashed.indexOf('7')); */
		$("#cash").val(cashed);
		})
</script>

<script>
function showMap(){
	/* 맵 추가 부분 */
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.3595704, 127.105399), //지도의 초기 중심 좌표
	    zoom: 12, //지도의 초기 줌 레벨
	    minZoom: 8, //지도의 최소 줌 레벨
	    maxZoom: 14,
	    zoomControl: true, //줌 컨트롤의 표시 여부
	    zoomControlOptions: { //줌 컨트롤의 옵션
	        position: naver.maps.Position.TOP_RIGHT
	    }
	});

	var myAddress=array_loc[1];
	console.log(myAddress);
	naver.maps.Service.geocode({address: myAddress}, function(status, response) {
	    if (status !== naver.maps.Service.Status.OK) {
	    	$("#map").css("text-align","center");
	    	$("#map").html("<br/><br/><br/><br/><br/><h3>해당 지역이 존재하지 않습니다.</h3>");
	    	return 0;
	        /* return alert(array_loc[1]+" "+array_loc[2]+" "+array_loc[0] + '의 검색 결과가 없거나 기타 네트워크 에러'); */
	    }
	    var result = response.result;
	    // 검색 결과 갯수: result.total
	    // 첫번째 결과 결과 주소: result.items[0].address
	    // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	    var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
	    map.setCenter(myaddr); // 검색된 좌표로 지도 이동
	    // 마커 표시
	    var marker = new naver.maps.Marker({
	      position: myaddr,
	      map: map
	    });
	    // 마커 클릭 이벤트 처리
	    naver.maps.Event.addListener(marker, "click", function(e) {
	      if (infowindow.getMap()) {
	          infowindow.close();
	      } else {
	          infowindow.open(map, marker);
	      }
	    });
	 // 마크 클릭시 인포윈도우 오픈
	    var infowindow = new naver.maps.InfoWindow({
	        content: "<div style='text-align: center;width:300px;'><h4 style='margin: 2px 20px;text-align: left;'>"+$("#title").text()
	        +"</h4><font size='2' color='gray'>("+array_loc[0]+")"+array_loc[1]+" "+array_loc[2]
	        +"</font><br/><img width='300px' height='200px' src='${param.mainPhoto}'></div>"
	    });
	});
};

</script>

</html>