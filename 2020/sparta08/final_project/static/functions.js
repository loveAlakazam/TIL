// $(document).ready(function(){...});
// 페이지를 새로고침하거나, 페이지를 불러올때 동작하는 함수.
// get current date and time
$(document).ready(function () {
    //현재 시각을 구한다.
    getCurrentTime();

    // 네이버 블로그 데이터를 업데이트한다.
    updateNaverBlogs();
});


// 현재 시각을 구한다. //
// 현재시각을 구하여, 아침/점심/저녁/야식 으로 구분. => 시간대별로 색깔이 달라짐.
function getCurrentTime() {
    let currentDate = new Date();
    let hour = currentDate.getHours();

    //현재 시각에 따라서 나타낸다
    $.ajax({
        type: 'POST',
        url: '/now',
        data: { 'give_time': hour },
        success: function (response) {
            //페이지 요청이 성공하면, 이에대한 응답함수
            if (response['result'] == 'success') {
                let mealTime = response['meal_time'];
                let sayhi1 = $('#sayHi1');
                let sayhi2 = $('#sayHi2');
                let sayhi3 = $('#sayHi3');

                sayhi1.text(`오늘 ${mealTime}은 뭘 먹을까요?`);
                sayhi2.text(`오늘 ${mealTime}은 사먹을까요? 요리해서 먹을까요?`);
                sayhi3.text(`오늘 ${mealTime}은 이거 어때요?`);

                // mealTime : 아침/점심/저녁/야식 에 따라서 container 배경색깔이 달라짐
                let mainContainer = $('#main_container');
                let searchContainers = $('#search_result_container');
                let footer = $('#footer');
                let colorVal;


                //메인페이지 백그라운드 컬러가 시간대에 따라 달라진다.
                if (mealTime == '아침') {
                    colorVal = "#f2d00c";

                } else if (mealTime == '점심') {
                    colorVal = '#31d7f5';

                } else if (mealTime == '저녁') {
                    colorVal = '#472fa1';
                } else { //야식
                    colorVal = '#210e66';
                }
                mainContainer.css('background-color', colorVal, opacity = 0.5);
                searchContainers.css('background-color', colorVal, opacity = 0.5);
                footer.css('background-color', colorVal, opacity = 0.5);

            }
        }
    });
}

// 페이지가 로드되거나 새로고침할때, 사용자가 볼수없는 부분
// 네이버 블로그 데이터를 수집하고 업데이트.
function updateNaverBlogs() {
    //먼저 메뉴옵션에 있는 모든 목록들을 가져온다.
    let menu_options = $('#inputGroupSelect_blog').children();
    let menus = [];
    for (let i = 0; i < menu_options.length; i++) {
        let current = menu_options[i].text;
        menus.push(current);
        
    }
    console.log(menus);

    $.ajax({
        type: 'POST',
        url: '/update/blog',
        data: {'menus_give' : menus}, // menus 리스트를 갖다준다.
        success: function (response) {
            //요청이 성공적으로 이뤄졌다면
            if(response['result']=='success'){
                console.log('네이버 블로그 데이터 업데이트 성공!');
            }
        }
    });
}


// nav탭을 누르면 - 네이버블로그/유튜브/ 맛집 방송
// 검색결과 컨테이너가 보이지 않도록 했다.
function hideResult() {
    let isOpen = $('#search_result_container').css('display');
    if (isOpen == 'block') {
        //현재 열린 상태라면,
        $('#search_result_container').hide();
    }
}

// 1. 네이버 블로그 nav탭 //
// 검색버튼을 누르면 실행하는 함수 //
function searchNaverBlogs() {
    // 선택한 메뉴 가져오기
    let selectMenu= $('#inputGroupSelect_blog option:selected').val();
    
    console.log('클라이언트가 선택한 메뉴: ', selectMenu);
    $.ajax({
        type: "POST",
        url: '/search/blogs/restaurant',
        data: { 'give_menu': selectMenu }, //옵션에서 선택한 메뉴를 서버에게 전달.
        success: function (response) {
            console.log(response);
            //데이터 요청이 성공하면..
            if(response['result']=='success'){

                //응답영역
                let blogs=response['blogs'];

                console.log(blogs);
                //검색결과 컨테이너를 보이게한다.
                let cardBox = $('#card-box');

                //기존에 있는 데이터를 지운다.
                cardBox.empty();

                blogs.forEach( blog => {
                    
                    // 블로그에 있는 값을 가져온다.
                    let title = blog['title'];
                    let author= blog['author'];
                    let url=blog['url'];
                    let menu=blog['menu'];

                    let card=`<div class="col mb-4">
                                <div class="card">
                                    <a href="${url}" class="blog_post_link">
                                        <div class="card-body">
                                            <h5 class="card-title">${title}</h5>
                                            <p class="card-text">${author}</p>
                                            <hr class="my-4">
                                            <p class="card-text"><small class="text-muted">${menu}</small></p>
                                        </div>
                                    </a>
                                </div>
                            </div>`;
                    // 카드 박스에 카드를 넣는다.
                    cardBox.append(card);
                });

                //검색결과 컨테이너를 보이게한다.
                $('#search_result_container').show();
            }
        }
    });
}

// 2. 유튜브 맛집 nav탭
// 검색버튼을 누르면 실행하는 함수//
function searchyoutubes() {

}

//3. 맛집방송 버튼 선택 하면 실행하는 함수//
// 카카오 검색결과를 링크로 적용: <a href="https://map.kakao.com/link/search/${address}"></a>
// 생방송투데이 클릭
function flavorToday() {
    $.ajax({
        type: "GET",
        url: '/search/famous/flavor/today',
        data: {},
        success: function (response) {
            if (response['result'] == 'success') {
                //검색결과 컨테이너를 보이게한다.
                let cardBox = $('#card-box');

                //기존에 있는 데이터를 지운다.
                cardBox.empty();

                //검색결과 식당
                restaurants = response['restaurants'];
                console.log(restaurants.length);

                restaurants.forEach(restaurant => {
                    let img_src = restaurant['img_url']; //이미지 정보
                    let name = restaurant['name']; //가게이름
                    let address = restaurant['address']; //가게주소
                    let menu = restaurant['menu']; //메뉴

                    let card = `
                    <div class="col mb-4">
                        <div class="card">
                            <img src="${img_src}" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${name}</h5>
                                <hr class="my-4">
                                <a href="https://map.kakao.com/link/search/${address}"><p class="card-text">${address}</p></a>
                                <p class="card-text"><small class="text-muted">${menu}</small></p>
                            </div>
                        </div>
                    </div>`;

                    cardBox.append(card);
                });

                //검색결과 컨테이너를 보이게한다.
                $('#search_result_container').show();
            }
        }
    });
}

// 생활의달인 클릭
function flavorMaster() {
    $.ajax({
        type: "GET",
        url: '/search/famous/flavor/master',
        data: {},
        success: function (response) {
            if (response['result'] == 'success') {
                //검색결과 컨테이너를 보이게한다.
                let cardBox = $('#card-box');

                //기존에 있는 데이터를 지운다.
                cardBox.empty();

                //검색결과 식당
                restaurants = response['restaurants'];
                restaurants.forEach(restaurant => {
                    let img_src = restaurant['img_url']; //이미지 정보
                    let name = restaurant['name']; //가게이름
                    let address = restaurant['address']; //가게주소
                    let menu = restaurant['menu']; //메뉴

                    let card = `
                    <div class="col mb-4">
                        <div class="card">
                            <img src="${img_src}" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${name}</h5>
                                <hr class="my-4">
                                <a href="https://map.kakao.com/link/search/${address}"><p class="card-text">${address}</p></a>
                                <p class="card-text"><small class="text-muted">${menu}</small></p>
                            </div>
                        </div>
                    </div>`;

                    cardBox.append(card);
                });

                //검색결과 컨테이너를 보이게한다.
                $('#search_result_container').show();
            }
        }
    });
}

// 생생정보통
function flavorInfos() {
    $.ajax({
        type: "GET",
        url: '/search/famous/flavor/info',
        data: {},
        success: function (response) {
            if (response['result'] == 'success') {
                //검색결과 컨테이너를 보이게한다.
                let cardBox = $('#card-box');

                //기존에 있는 데이터를 지운다.
                cardBox.empty();

                //검색결과 식당
                restaurants = response['restaurants'];
                restaurants.forEach(restaurant => {
                    let img_src = restaurant['img_url']; //이미지 정보
                    let name = restaurant['name']; //가게이름
                    let address = restaurant['address']; //가게주소
                    let menu = restaurant['menu']; //메뉴

                    let card = `
                    <div class="col mb-4">
                        <div class="card">
                            <img src="${img_src}" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">${name}</h5>
                                <hr class="my-4">
                                <a href="https://map.kakao.com/link/search/${address}"><p class="card-text">${address}</p></a>
                                <p class="card-text"><small class="text-muted">${menu}</small></p>
                            </div>
                        </div>
                    </div>`;

                    cardBox.append(card);
                }); //for-each문 종료
                $('#search_result_container').show();

            }
        }
    });
}
