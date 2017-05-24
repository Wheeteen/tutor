(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data:{
        domain:'http://www.shendaedu.com/',
        // domain: 'http://shaozi.beansonbar.cn/',
        status:{
         isLoading: false,
        },
        form:{
         myImg: '../img/user.png',
         name: '',
        },
      },
      ready:function(){
         this.getImage();
         this.status.isLoading = true;
      },
      methods:{
      	getImage: function(){
          this.$http.get(this.domain+'getWechatInfo', {
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res) {
            console.log(res.json());
            this.form.myImg=res.json().headimgurl;
            this.form.name = res.json().nickname;  
          });
        },
        onRecommend: function(){
          window.location.href = './teacherPage.html';
        },
      	onchangeInfo: function(){
          window.location.href = './teacherResume.html?change';
        },
      	onMsg:function(){
      		window.location.href = './myMessage.html?teacher';
      	},
      	onTeacher:function(){
      		window.location.href = './myList.html';
      	},
      }
	});
})();