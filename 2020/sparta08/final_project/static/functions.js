// get current date and time
$(document).ready(function(){
    //현재 시각을 구한다.
    getCurrentTime(); 
});

// 현재 시각을 구한다.
// 현재시각을 구하여, 아침/점심/저녁/야식 으로 구분.
function getCurrentTime(){
    let currentDate= new Date();
    let hour=currentDate.getHours();

    //현재 시각에 따라서 나타낸다
    $.ajax({
        type:'POST',
        url:'/now',
        data:{'give_time': hour},
        success: function(response){
            //페이지 요청이 성공하면, 이에대한 응답함수
            if(response['result']=='success'){
                let mealTime= response['meal_time'];
                let sayhi1=$('#sayHi1');
                let sayhi2=$('#sayHi2');
                let sayhi3=$('#sayHi3');
                
                sayhi1.text(`오늘 ${mealTime}은 뭘 먹을까요?`);
                sayhi2.text(`오늘 ${mealTime}은 사먹을까요? 요리해서 먹을까요?`);
                sayhi3.text(`오늘 ${mealTime}은 이거 어때요?`);
            }
        }
    });
}
