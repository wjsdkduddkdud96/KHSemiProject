<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>세상의 잠든 공간을 깨우다. - WAKE UP PLACE</title>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <style>
            /* body {text-align: center;} */
            table { margin: 10px; width: 95%; }
            td { border: 1px solid black; font-size: 13; }

            #keyword_input {
            	width: 250px; 
            	border-top: 2px solid white; 
            	border-left: 2px solid white; 
            	border-right: 2px solid white; 
            	border-bottom: 3px solid black; 
            	margin-right: 10px;
                margin-top: 50px;
                text-align: center;
            }
            
			#search_header{ position: absolute; top: 0px; left: 0px; width: 650px; text-align: center;}
			#search_listBox{ width: 1110px; height: 480px; display: inline-block; position: absolute; top: 180px; left: 0px; z-index: 1; text-align:left; }
			#search_footer{ position: absolute; top: 680px; left: 0px; z-index: 2; }
            .button_css { width: 80px; border: 0px solid white; background-color: black; color: white; height: 30px; }
            
            .category_div { background-color: white; width: 100px; margin: 7px 0px; text-align: center; display: inline-block; border: 1px solid black; }
            

            #location_divAll { border: 1px solid black; width: 400px; height: auto; display: inline-block; background-color: black; position: relative; z-index: 2; }
            #location_title { width: 100%; height: 20px; text-align: center; color: white; padding: 0px; }
            #location_main { width: 100%; height:0px; background-color: white; display: none; margin-top: 1px; text-align: center; }
            #location_button { color: black; display: inline; float: right; background-color: white; height: 100%; padding: 5px 3px; }
            #location_text { margin-top: 5px; padding-top: 3px; display: inline-block; }
            .location_div { background-color: white; width: 70px; margin: 2px 2px; border: 1px solid black; padding: 10px 5px; display: inline-block; }
           
            .place_div { margin: 10px 10px; display: inline-block; width: 350px;/* 100% */ height:460px;/* 95% */ background-color: #FAFAFA; }
            .place_name { border: 0px solid black; font-size: 20; font-weight: 600; }
            .place_td { background-color: #FE2E64; color: white; text-align: center; }

            .place_div:hover { cursor: pointer; background-color:rgba(200, 200, 200, 0.5); box-shadow: 5px 5px 5px #888888;}
            .button_css:hover {cursor: pointer;}
            .category_div:hover {cursor: pointer; box-shadow: 3px 3px 1px #888888;}
            .location_div:hover { cursor: pointer; box-shadow: 3px 3px 1px #888888; }
            #location_button:hover { cursor: pointer; }
            #location_text:hover{ cursor: default; }
            #search_listBox:hover{ cursor: default; }
            
        </style>
    </head>

    <body>
        <jsp:include page="menuBar.jsp" />
        <div id="search_header">
            <input id="keyword_input" type="text" placeholder="상호명을 입력해주세요." />
            <button id="main_btn" class="button_css">검색</button>
            <br>
            <div class="category_div">카페</div>
            <div class="category_div">식당</div>
            <div class="category_div">주점</div>
            <div class="category_div">스튜디오</div>
            <div class="category_div">연습실</div>
            <div class="category_div">공연장</div>
            <br />
            <div id="location_divAll">
                <div id="location_title">
                    <div id="location_text">지역 선택</div>
                    <div id="location_button">▼</div>
                </div>
                <div id="location_main">
                    <div class="location_div">강남구</div>
                    <div class="location_div">강동구</div>
                    <div class="location_div">강북구</div>
                    <div class="location_div">강서구</div>
                    <div class="location_div">관악구</div>
                    <div class="location_div">광진구</div>
                    <div class="location_div">구로구</div>
                    <div class="location_div">금천구</div>
                    <div class="location_div">노원구</div>
                    <div class="location_div">도봉구</div>
                    <div class="location_div">동대문구</div>
                    <div class="location_div">동작구</div>
                    <div class="location_div">마포구</div>
                    <div class="location_div">서대문구</div>
                    <div class="location_div">서초구</div>
                    <div class="location_div">성동구</div>
                    <div class="location_div">성북구</div>
                    <div class="location_div">송파구</div>
                    <div class="location_div">양천구</div>
                    <div class="location_div">영등포구</div>
                    <div class="location_div">용산구</div>
                    <div class="location_div">은평구</div>
                    <div class="location_div">종로구</div>
                    <div class="location_div">중구</div>
                    <div class="location_div">중랑구</div>
                </div>
            </div>
            <br />
        </div>
        <div id="search_listBox"></div>
        
        <div id="search_footer">
            <button id="before" class="button_css">이전 목록</button> &nbsp;&nbsp;&nbsp;&nbsp;
            <button id="after" class="button_css">다음 목록</button>
        </div>
    </body>
    <script>
        var category = "none";
        <%if(request.getParameter("category")!=null){%>
        category='<%=request.getParameter("category")%>';
        
        $("div.category_div").each(function(idx,elem){
        	if(elem.innerHTML==category){
        		elem.style.color="white";
        		elem.style.backgroundColor="#FE2E64";
        	}
        });
        
        history.pushState(null, null, "./search.jsp"); //페이지 이동 없이 url 변경(HTML5 이상 가능)
        <%request.removeAttribute("category");
        }%>
        
        var keyword= "none";
        var loc = "none";
        var start = 1;
        var end = 6;

        $("#search_listBox").css("left", window.innerWidth / 2 - 555);
        $("#search_footer").css("left", window.innerWidth / 2 - 97);
        $("#search_header").css("left", window.innerWidth / 2 - 325);

        $(document).ready(function() {
            placeSearch(keyword, category, loc, start, end);
        });

        function placeSearch(keyword, category, area, start, end) {
            var obj = {};
            obj.error = function(err) {
                console.log(err)
            };
            obj.type = "POST";
            obj.dataType = "JSON";

            obj.url = "./placeSearch";
            obj.data = {
                keyword: keyword,
                category: category,
                area: area,
                start: start,
                end: end
            };
            obj.success = function(data) {
                placeList(data.list);
            }
            $.ajax(obj);
        };

        function placeList(list) {
        	$("#search_listBox").css("height","480px");
        	$("#search_footer").css("top","680px");
            $("#location_main").css("display", "none");
            $("#location_main").css("height", "0px");
            $("#location_button").text("▼");
            if (list.length != 0) {
                $("div.place_div").remove();
                $("div#search_listBox").empty();
                var newLine = "";
                list.forEach(function(item, i) {
                    newLine += "<div class='place_div'>";
                    newLine += "<input type='hidden' value='" + item.place_no + "'/>";
                    newLine += "<div style='width: 100%; height: 60%; padding:2.5%;'>"
                    newLine += "<img width='95%' height='95%' src='./upload/" + item.place_photo + "'/>";
                    newLine += "</div>";
                    newLine += "<div style='text-align: left;'>";
                    newLine += "<table>";
                    newLine += "<tr><td colspan='2' class='place_name'>" + item.place_name + "</td></tr>"
                    
                    var str=item.place_loc.split("/");
                    
                    newLine += "<tr><td class='place_td'>" + item.place_category + "</td><td class='place_td'>" +str[1]+" "+str[2]+ "</td></tr>";
                    newLine += "<tr><td colspan='2'>" + item.place_info + "</td></tr>";
                    newLine += "<tr><td colspan='2' class='place_td'>" + item.place_price + "</td></tr>";
                    newLine += "</table>";
                    newLine += "</div>";
                    newLine += "</div>";
                    if(i==3){
                    	$("#search_listBox").css("height","960px");
                    	$("#search_footer").css("top","1180px");
                    }
                });
                $("#search_listBox").append(newLine);
                $("div.place_div").click(function() {
                    location.href = "./placeDetailUp?place_no=" + $(this).children("input[type='hidden']").val() + "&page=placeDetail.jsp";
                });
            } else {
                $("#search_listBox").html("<br/><br/><br/><br/><br/><span style='text-align:center;'><h3>해당 검색 결과가 더 이상 존재하지 않습니다.</h3></span>");
            }
        };

        $("#location_button").click(function() {
            var so = $("#location_main").css("display");
            if (so == "none") {
                $("#location_main").css("display", "inline-block");
                $("#location_main").animate({"height": "329px"}, "slow");
                $("#location_button").text("▲");
            } else {
                $("#location_main").css("display", "none");
                $("#location_main").css("height", "0px");
                $("#location_button").text("▼");
            }
        });

        $("div.category_div").on("mouseover",function(){
        	if ($(this).css("background-color") != "rgb(254, 46, 100)"){
        	$(this).css("background-color", "rgba(255, 102, 102, 0.4)");
        	}
        });
        $("div.category_div").on("mouseout",function(){
        	if ($(this).css("background-color") != "rgb(254, 46, 100)"){
        	$(this).css("background-color", "white");
        	}
        });
        $("div.category_div").on("click",function() {
            if ($(this).css("background-color") == "rgb(254, 46, 100)") {
                $(this).css("background-color", "white");
                $(this).css("color", "black");
                category = "none";
                start = 1;
                end = 6;
                placeSearch(keyword, category, loc, start, end);
            } else {
                $("div.category_div").css("background-color", "white");
                $("div.category_div").css("color", "black");
                $(this).css("color", "white");
                $(this).css("background-color", "#FE2E64");
                category = $(this).text();
                start = 1;
                end = 6;
                placeSearch(keyword, category, loc, start, end);
            }
        });
        $("div.location_div").click(function() {
            if ($(this).css("background-color") == "rgb(254, 46, 100)") {
                $(this).css("background-color", "white");
                $(this).css("color", "black");
                loc = "none";
                start = 1;
                end = 6;
                placeSearch(keyword, category, loc, start, end);
            } else {
                $("div.location_div").css("background-color", "white");
                $("div.location_div").css("color", "black");
                $(this).css("color", "white");
                $(this).css("background-color", "#FE2E64");
                loc = $(this).text();
                start = 1;
                end = 6;
                placeSearch(keyword, category, loc, start, end);
            }
        });
        $("div.location_div").on("mouseover",function(){
        	if ($(this).css("background-color") != "rgb(254, 46, 100)"){
        	$(this).css("background-color", "rgba(255, 102, 102, 0.4)");
        	}
        });
        $("div.location_div").on("mouseout",function(){
        	if ($(this).css("background-color") != "rgb(254, 46, 100)"){
        	$(this).css("background-color", "white");
        	}
        });
        
        $("#main_btn").click(function() {
            category = "none";
            keyword = "none";
            loc = "none";
            start = 1;
            end = 6;

            if ($("#keyword_input").val() != "") {
                keyword = $("#keyword_input").val();
            }
            $("div.category_div").each(function(index, item) {
                if ($(this).css("background-color") != "rgb(255, 255, 255)") {
                    category = $(this).text();
                }
            });
            $("div.location_div").each(function(index, item) {
                if ($(this).css("background-color") != "rgb(255, 255, 255)") {
                    loc = $(this).text();
                }
            });
            placeSearch(keyword, category, loc, start, end);
        });

        $("#before").click(function() {
            if (start >= 7) {
                start = start - 6;
                end = end - 6;
            }
            placeSearch(keyword, category, loc, start, end);
        });

        $("#after").click(function() {
            if ($("#search_listBox").children("div").length) {
                start = start + 6;
                end = end + 6;
            }
            placeSearch(keyword, category, loc, start, end);
        })

        $(window).resize(function() {
            $("#search_listBox").css("left", window.innerWidth / 2 - 555);
            $("#search_footer").css("left", window.innerWidth / 2 - 97);
            $("#search_header").css("left", window.innerWidth / 2 - 325);
        });
    </script>

</html>