let index = {
    init: function (){
        $("#btn-save").on("click",()=>{
            this.save();
        });


    },

    save:function (){
        let data={
            title: $("#title").val(),
            content: $("#content").val(),
            email: $("#email").val()
        }
        
        $.ajax({
            //회원가입 수행 요청(100초 가정)
            type: "POST",
            url:"/api/board",
            data: JSON.stringify(data), //json문자열로 변환, http body데이터
            contentType: "application/json; charset=utf-8", //바디데이터가 어떤 타입인지(MIME)
            dataType:"json" //요청을 서버로 해서 응답이 왔을 때 기본적으로 모든것이 문자열(생긴 게 json이라면
            //=> javascript 객체로 변환
            //ajax가 통신을 성공하고 나서 서버가 json을 리턴해주면 자동으로 자바 오브젝트로 변환해줌
        }).done(function(resp){
            alert("글쓰기가 완료되었습니다.");
            //console.log(resp);
            location.href="/"; //반환 위치
        }).fail(function (error){
            alert(JSON.stringify(error));
        }); //ajax 통신을 이용해서 3개의 데이터를 json으로 변경하여 insert요청

    //1.2.3.하다가 올라가 서 비동기 실행
    }


}
index.init();