(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data:{
        // domain:'http://www.shendaedu.com/',
        domain: 'http://shaozi.beansonbar.cn/',
        status:{
         	isChangeInfo: false,
          isLoading: false
        },
        form:{
          myImg: '../img/user02.png',
          name: '',
        },
        remind: 1
      },
      ready:function(){
         this.getImage();
         this.status.isLoading = true;
      },
      watch: {
        'remind':function(res){
          var status;
          if(res==true){
            status=1;
          }else{
            status = 0;
          }
          this.$http.post(this.domain+'setMessageWarn', {
            "status": status
          }, {
            emulateJSON:true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res) {
              console.log(res.json());
          });
        }
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
            this.remind = res.json().message_warn;
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