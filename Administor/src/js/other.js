(function(){
	var vm = new Vue({
      el: 'body',
      data:{
        status:{
      	  isUser: false,
      	  isDeal: false,
      	  isOther: true,
          isLoading: false,
   
      	},
      },
      ready: function(){
      	this.status.isLoading = true;
      },
      methods:{
      	onUser:function(){
      		window.location.href = './userAdministor.html';
      	},
      	onDeal: function(){
          window.location.href = './deal.html';
      	},
      	onOther: function(){
      		window.location.href = './other.html';
      	},
      	onExamine: function(){
      		window.location.href = './examine.html';
      	},
        onPopularTeacher: function(){
          window.location.href='./popularTeacher.html';
        },
        onQuestion: function(){
          window.location.href = './parentQuestion.html?changeInfo';
        },
        onFeedback: function(){
          window.location.href = './feedback.html';
        },
        onBanner: function(){
          window.location.href = './banner.html';
        },
        onText: function(){
          window.location.href = './textChange.html';
        }
      }
	});
})();