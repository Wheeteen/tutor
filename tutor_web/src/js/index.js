(function(){
	var vm = new Vue({
      el: 'body',
      data: {
        
      },
      methods: {
        
        onParent: function(){
          console.log(idParent);
          // this.onSubmit();
          if(idParent!==''&& idParent !== null){
          	window.location.href = './view/parentPage.html';
          }else{
          	window.location.href = './view/parentQuestion.html';
          }
        },
        onTeacher: function(){
          // this.onSubmit();
          if(idTeacher!==''&& idTeacher !== null){
          	window.location.href = './view/teacherPage.html';
          }else{
          	window.location.href = './view/teacherLogin.html';
          }
        },
       
      }
	});
})();