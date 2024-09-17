<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="TEAMINFO"></c:set>
<link rel="stylesheet" href="/resource/teamInfo.css" />

<%@ include file="../common/head.jspf"%>



<div class="teamInfoSection">
	<div class="team">
		<div class="teamInfo">
			<div class="teamLogo">
				<img class="image" src="/images/teamLogos/doosan.png" data-team="DS" />
				<img class="image" src="/images/teamLogos/lg.png" data-team="LG" />
				<img class="image" src="/images/teamLogos/kia.png" data-team="KIA" />
				<img class="image" src="/images/teamLogos/kt.png" data-team="KT" />
				<img class="image" src="/images/teamLogos/samsung.png" data-team="SS" />
				<img class="image" src="/images/teamLogos/hanhwa.png" data-team="HH" />
				<img class="image" src="/images/teamLogos/ssg.png" data-team="SSG" />
				<img class="image" src="/images/teamLogos/nc.png" data-team="NC" />
				<img class="image" src="/images/teamLogos/lotte.png" data-team="LT" />
				<img class="image" src="/images/teamLogos/kiwoom.png" data-team="KW" />
			</div>
			<div class="info">
				<img class="stadiumImage" src="/images/stadiumImages/doosan.png" />
				<div class="stadium"></div>
				<div class="address"></div>
				<div class="doosan teamColor">
					<div class="find ">
						<a href="#" class="find-map-link">찾아가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 지도 및 카테고리 -->
<div class="mapContainer">
	<p>
		<em class="link">
			<a href="/web/documentation/#CategoryCode" target="_blank"></a>
		</em>
	</p>
	<div class="map_wrap">
		<!-- 지도 컨테이너 -->
		<div id="map" style="width: 800px; height: 600px; position: absolute; top: 150px; left: -100px;"></div>

		<!-- 카테고리 리스트 -->
		<ul id="category">
			<li id="BK9" data-order="0">
				<span class="category_bg bank"></span>
				은행
			</li>
			<li id="MT1" data-order="1">
				<span class="category_bg mart"></span>
				마트
			</li>
			<li id="PM9" data-order="2">
				<span class="category_bg pharmacy"></span>
				약국
			</li>
			<li id="OL7" data-order="3">
				<span class="category_bg oil"></span>
				주유소
			</li>
			<li id="CE7" data-order="4">
				<span class="category_bg cafe"></span>
				카페
			</li>
			<li id="CS2" data-order="5">
				<span class="category_bg store"></span>
				편의점
			</li>
		</ul>
	</div>
</div>

<!-- 카카오 지도 API를 포함합니다 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f1f9a79eb50b08adc48c36903d8e7bdc&libraries=services"></script>
<script>
    var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 3 }), contentNode = document.createElement('div'), markers = [], currCategory = '';

    // 브라우저의 Geolocation API를 사용하여 위치 가져오기
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    initializeMap(latitude, longitude);  // 사용자 위치로 지도 중심 설정
                },
                function(error) {
                    console.error('Geolocation error:', error);
                    // 위치 정보 가져오기 실패 시 기본 좌표 설정 (서울 시청)
                    initializeMap(37.566826, 126.9786567);
                }
            );
        } else {
            console.error('Geolocation is not supported by this browser.');
            // Geolocation 지원 안 함 시 기본 좌표 설정 (서울 시청)
            initializeMap(37.566826, 126.9786567);
        }
    }

    getLocation(); // 위치 정보 가져오기
    
    // 지도를 초기화하는 함수
    function initializeMap(latitude, longitude) {
    	console.log('User Latitude: ', latitude);  // 사용자 위도 콘솔 출력
        console.log('User Longitude: ', longitude); // 사용자 경도 콘솔 출력
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(latitude, longitude),  // 사용자의 위치로 중심 설정
            level: 5
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var ps = new kakao.maps.services.Places(map);
        var marker;

        // "찾아가기" 링크 클릭 시 처리
        document.querySelector('.find-map-link').addEventListener('click', function(event) {
            event.preventDefault();
            var lat = parseFloat(this.getAttribute('data-lat'));
            var lng = parseFloat(this.getAttribute('data-lng'));
            var placeName = this.getAttribute('data-place-name');
            var placeUrl = this.getAttribute('data-place-url');
            var roadAddressName = this.getAttribute('data-road-address-name');
            var addressName = this.getAttribute('data-address-name');
            var phone = this.getAttribute('data-phone');

            var newCenter = new kakao.maps.LatLng(lat, lng);
            map.setCenter(newCenter);

            if (marker) {
                marker.setMap(null);
            }

            marker = new kakao.maps.Marker({
                position: newCenter
            });
            marker.setMap(map);

            var place = {
                place_name: placeName,
                place_url: placeUrl,
                road_address_name: roadAddressName,
                address_name: addressName,
                phone: phone,
                x: lng,
                y: lat
            };

            displayPlaceInfo(place);
            map.setLevel(3);
        });

        // 카테고리 클릭 이벤트 추가
        addCategoryClickEvent();

        // 이벤트 핸들러 추가 함수
        function addEventHandle(target, type, callback) {
            if (target.addEventListener) {
                target.addEventListener(type, callback);
            } else {
                target.attachEvent('on' + type, callback);
            }
        }

        // 현재 카테고리로 장소를 검색합니다
        function searchPlaces() {
            if (!currCategory) {
                return;
            }

            placeOverlay.setMap(null);
            removeMarker();

            ps.categorySearch(currCategory, placesSearchCB, { useMapBounds: true });
        }

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data);
            }
        }

        function displayPlaces(places) {
            var order = document.getElementById(currCategory).getAttribute('data-order');
            for (var i = 0; i < places.length; i++) {
                var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

                (function(marker, place) {
                    kakao.maps.event.addListener(marker, 'click', function() {
                        displayPlaceInfo(place);
                    });
                })(marker, places[i]);
            }
        }

        function addMarker(position, order) {
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png',
                imageSize = new kakao.maps.Size(27, 28),
                imgOptions = {
                    spriteSize: new kakao.maps.Size(72, 208),
                    spriteOrigin: new kakao.maps.Point(46, (order * 36)),
                    offset: new kakao.maps.Point(11, 28)
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position,
                    image: markerImage
                });

            marker.setMap(map);
            markers.push(marker);
            return marker;
        }

        function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        function displayPlaceInfo(place) {
            var content = '<div class="placeinfo">' +
                '<a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';
            if (place.road_address_name) {
                content += '<span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                    '<span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
            } else {
                content += '<span title="' + place.address_name + '">' + place.address_name + '</span>';
            }
            content += '<span class="tel">' + place.phone + '</span>' + '</div>' + '<div class="after"></div>';

            contentNode.innerHTML = content;
            placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
            placeOverlay.setMap(map);
        }

        function addCategoryClickEvent() {
            var category = document.getElementById('category'),
                children = category.children;

            for (var i = 0; i < children.length; i++) {
                children[i].onclick = onClickCategory;
            }
        }

        function onClickCategory() {
            var id = this.id,
                className = this.className;

            placeOverlay.setMap(null);

            if (className === 'on') {
                currCategory = '';
                changeCategoryClass();
                removeMarker();
            } else {
                currCategory = id;
                changeCategoryClass(this);
                searchPlaces();
            }
        }

        function changeCategoryClass(el) {
            var category = document.getElementById('category'),
                children = category.children,
                i;

            for (i = 0; i < children.length; i++) {
                children[i].className = '';
            }

            if (el) {
                el.className = 'on';
            }
        }
    }

</script>

<!-- 구장정보 -->
<script>
<!-- 필요한 데이터를 stadiumData 객체에 저장 -->
const stadiumData = {
	    HH: {
	        name: "홈구장 : 대전 한화생명 이글스파크",
	        address: "주소 : 대전 중구 대종로 373 한밭종합운동장 한화생명 이글스파크",
	        image: "/images/stadiumImages/hanhwa.png",
	        class: "hanhwa teamColor",
	        lng: 127.4291345,
	        lat: 36.3170789,
	        url: "https://place.map.kakao.com/8131581",
	        phone: "042-630-8200"
	    },
	    DS: {
	        name: "홈구장 : 잠실 야구장",
	        address: "주소 : 서울특별시 송파구 올림픽로 19-2 서울종합운동장",
		    image: "/images/stadiumImages/doosan.png",
		    class: "doosan teamColor",
		    lng: 127.0719011,
	        lat: 37.5122579,
	        url: "https://place.map.kakao.com/20740490",
	        phone: "1661-0965"	        
	    },
	    LG: {
	        name: "홈구장 : 잠실 야구장",
	        address: "주소 : 서울특별시 송파구 올림픽로 19-2 서울종합운동장",
	        image: "/images/stadiumImages/doosan.png",
			class: "lg teamColor",
		    lng: 127.0719011,
	        lat: 37.5122579,
	        url: "https://place.map.kakao.com/20740490",
	        phone: "1661-0965"
	    },
	    LT: {
	        name: "홈구장 : 사직 야구장",
	        address: "주소 : 부산광역시 동래구 사직로 45",
	        image: "/images/stadiumImages/lotte.png",
		    class: "lotte teamColor",
		    lng: 129.0615183,
		    lat: 35.1940316,
	        url: "https://place.map.kakao.com/8396881",
	        phone: "051-852-1982"	
	    },
	    SSG: {
	        name: "홈구장 : SSG 랜더스 필드",
	        address: "주소 : 인천 미추홀구 매소홀로 618",
	        image: "/images/stadiumImages/ssg.png",
		    class: "ssg teamColor",
		    lng: 126.6932617,
	        lat: 37.4370423,
	        url: "https://place.map.kakao.com/8053130",
	        phone: "032-455-2600"	
	    },
	    SS: {
	        name: "홈구장 : 대구 삼성 라이온즈 파크",
	        address: "주소 : 대구광역시 수성구 야구전설로 1",
	        image: "/images/stadiumImages/samsung.png",
		    class: "samsung teamColor",
		    lng: 128.6815273,
		    lat: 35.8411705,
	        url: "https://place.map.kakao.com/12864272",
	        phone: "053-780-3300"
	    },
	    KW: {
	        name: "홈구장 : 고척 스카이돔",
	        address: "주소 : 서울 구로구 경인로 430",
	        image: "/images/stadiumImages/kiwoom.png",
		    class: "kiwoom teamColor",
		    lng: 126.867,
	        lat: 37.498,
	        url: "https://place.map.kakao.com/7890664",
	        phone: "1666-3102"
	    },
	    NC: {
	        name: "홈구장 : 창원 NC파크",
	        address: "주소 : 경남 창원시 마산회원구 삼호로 63",
	        image: "/images/stadiumImages/nc.png",
		    class: "nc teamColor",
		    lng: 128.5823895,
		    lat: 35.2225335 ,
	        url: "https://place.map.kakao.com/26542435",
	        phone: "1644-9112"
	    },
	    KIA: {
	        name: "홈구장 : 광주-KIA 챔피언스필드",
	        address: "주소 : 광주광역시 북구 서림로 10",
	        image: "/images/stadiumImages/kia.png",
		    class: "kia teamColor",
		    lng: 126.8891056,
	        lat: 35.1681242,
	        url: "https://place.map.kakao.com/21755436",
	        phone: "070-7686-8000"
	    },
	    KT: {
	        name: "홈구장 : 수원 KT 위즈파크",
	        address: "주소 : 경기도 수원시 장안구 경수대로 893",
	        image: "/images/stadiumImages/kt.png",
		    class: "kt teamColor",
		    lng: 127.0096685,
		    lat: 37.2997553,
	        url: "https://place.map.kakao.com/17577962",
	        phone: "1899-5916"
	    }
	};

<!-- 구단 로고를 클릭했을 때 각 구장 정보가 나오게끔 하는 함수 -->
document.querySelectorAll('.image').forEach(logo => {
    logo.addEventListener('click', function() {
        const team = this.getAttribute('data-team');
        const stadium = stadiumData[team];

        if (stadium) {
            // 정보를 업데이트
            document.querySelector('.stadium').textContent = stadium.name; // 클래스가 stadium인 곳에 stadium.name을 넣는다.
            document.querySelector('.address').textContent = stadium.address; // 클래스가 address인 곳에 stadium.address을 넣는다.
            document.querySelector('.stadiumImage').src = stadium.image; // 클래스가 stadiumImage인 곳에 stadium.image을 넣는다.
            
            const teamColorDiv = document.querySelector('.teamColor');
            teamColorDiv.className = stadium.class; // 클래스가 teamColor인 element를 찾아 클래스명에 stadium.class로 바꿔준다.
            
         	// "찾아가기" 에 해당하는 정보 데이터 설정
            const findLink = document.querySelector('.find-map-link');
            findLink.setAttribute('data-lat', stadium.lat); // 위도값 설정
            findLink.setAttribute('data-lng', stadium.lng); // 경도값 설정
            
            // 접두사 제거
            const nameWithoutPrefix = stadium.name.replace('홈구장 : ', ''); // '홈구장 : '을 지우고 뒤에 구장명만 가져오기 위해 추가
            const addressWithoutPrefix = stadium.address.replace('주소 : ', ''); // '주소 : ' 를 지우고 뒤에 주소에 해당하는 부분만 가져오기 위해 추가
            
            findLink.setAttribute('data-place-name', nameWithoutPrefix); // 구장명 설정
            findLink.setAttribute('data-place-url', stadium.url); // 누르면 새창으로 열릴 url 설정
            findLink.setAttribute('data-road-address-name', addressWithoutPrefix); // 도로명 주소 설정
            findLink.setAttribute('data-address-name', addressWithoutPrefix); // 주소 설정
            findLink.setAttribute('data-phone', stadium.phone);  // 전화번호 설정

            // 구장정보 보여주기 = 홈구장, 주소, 찾아가기 버튼'
            document.querySelector('.info').style.display = 'block';
        }
    });
});
</script>


<%@ include file="../common/foot.jspf"%>