// // vanilla js
// // querySelector() : css 선택자에 대응하는 요소중 첫번째 요소
// // 선택된 요소는 css적용이 가능하다.

// // toggleBtn: 클래스이름이 "navbar_toggle"에 해당하는 요소와 연결.
// const toggleBtn= document.querySelector('.navbar_toggle');


// //menu: 클래스이름이 "navbar_menu"에 해당하는 요소와 연결하기
// const menu=document.querySelector('.navbar_menu');


// //icons: 클래스이름이 "navbar_icons"에 해당하는 요소와 연결하기
// const icons= document.querySelector('.navbar_icons');


// //버튼이 클릭될때마다 active클래스를 발생.
// toggleBtn.addEventListener('click', ()=>{
//     //menu와 icons를 active로 토글링(on/off)한다.
//     menu.classList.toggle('active');
//     icons.classList.toggle('active');
// });


//jquery
//자동으로 실행하는 함수
$(function(){
    const toggleBtn=$('.navbar_toggle');
    const menu=$('.navbar_menu');
    const icons=$('.navbar_icons');

    //토글버튼을 클릭하면
    $(toggleBtn).click(function(){
        menu.addClass("active"); //active 클래스 추가
        icons.addClass("active");
    });
});

