(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data:{
        domain:'http://www.yinzishao.cn:8000/',
        status:{
         	isChangeInfo: false,
          isLoading: false
        },
        form:{
          myImg: '../img/user02.png',
          name: '',
        },
      },
      ready:function(){
         this.getImage();
         this.status.isLoading = true;
      },
      watch: {
        // 'form.remindInfo':function(res){
        //     this.$http.post('', {
        //     	'id':id,
        //     	'remindInfo' : res
        //     }, {
        //       emulateJSON:true,
        //       headers:{
        //         'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8' 
        //       }
        //     }).then(function(res) {
             
        //     });
        // }
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
            // if(res.json().result == 0){
            //  this.form.remindInfo = false;
            // }else{
            //  this.form.remindInfo = true;
            // }    
          });
        },
        onRecommend: function(){
          window.location.href = './parentPage.html';
        },
        onMine: function(){
        	this.status.isChangeInfo = false;
        },
        onchangeInfo:function(){
           this.status.isChangeInfo= true;
      	},
      	onCancel: function(){
      		this.status.isChangeInfo = false;
      	},
      	onSureChange: function(){
      		location.href='./parentQuestion.html?updateParent';
      	},
      	onMsg:function(){
      		location.href = './myMessage.html?parent';
      	},
      	onTeacher:function(){
      		location.href = './myTeacher.html';
      	},
        
      }
	});
})();