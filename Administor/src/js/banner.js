(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        domain: 'http://shaozi.beansonbar.cn',
        status:{
  	  	  isUser: false,
  	  	  isDeal: true,
  	  	  isOther: false,
          isLoading: false,
          isUploadImg: false,
          isDeleteImg: false,
          selected: '',
      	},
        signature: '',
        imgs: [],
        form: {
          image: '',
          url: '',
          serverId: '',
        }
      },
      computed: {
        isOnSubmit: function(){
          if(this.form.serverId != ''){
            return true;
          }else{
            return false;
          }
        }
      },
      ready: function(){
      	this.render();
        this.status.isLoading = true;
      },
      methods: {
        getSignature: function(){        
          this.$http.post(this.domain+'/generate_signature',{
            timestamp: 1482652615,
            nonceStr: 'yinzishao',
          },{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            console.log(res.json());
            this.signature = res.json().signature;
            var self = this;
            wx.config({
              debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
              appId: 'wx6fe7f0568b75d925', // 必填，公众号的唯一标识
              timestamp: 1482652615, // 必填，生成签名的时间戳
              nonceStr:'yinzishao' , // 必填，生成签名的随机串
              signature: self.signature,// 必填，签名，见附录1
              jsApiList: ['chooseImage','uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
          })                
        },
      	render: function(){
          this.$http.post(this.domain+'/getText',{
              'key':['getImg']
            },{
              crossOrigin: true,
              headers:{
                    'Content-Type':'application/json' 
                  }
            }).then(function(res) {
              console.log(res.json());
              if(res.json().success == 1){
                var data = res.json().getImg;
                for(var i = 0;i<data.length;i++){
                  var img = data[i].img;
                  data[i].img = this.domain+img;               
                }
                this.$set('imgs', data);
              }else{
                console.log(res.json().error);
              }       
          });
      	},
        
        onUser:function(){
          window.location.href = './userAdministor.html';
        },
        onDeal: function(){
          window.location.href = './deal.html';
        },
        onOther: function(){
          window.location.href = './other.html';
        },
       
        onClose: function(){
        	this.status.isUploadImg = false;
        },
        onClickImg: function(){
          if(this.signature==''){
            this.getSignature();
          }
          this.status.isUploadImg = true;           
        },
        onSubmitImg: function(index){
          if(this.form.serverId!== ''){
            this.$http.post(this.domain+'/changeText', {
              "image":this.form.serverId,
              "url": this.form.url
            }, {
              crossOrigin:true,
              headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res) {
              console.log(res.json());
              if (res.json().success == 1) {
                this.status.isUploadImg = false;
                this.imgs.push({
                  'img':this.domain+res.json().image
                });
                this.form.image = '';
                this.form.serverId="";
                this.form.url = '';
              }
            }); 
          }else{
            return false;
          }
           
        },
        uploadImg: function(){
          var self = this;
          wx.ready(function(){
            wx.chooseImage({
              count: 1, // 默认9
              sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
              sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
              success: function (res) {
                console.log(res);
                var localId = res.localIds[0]; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片          
                self.form.image = localId;
                self.uploadImgTo(localId);
              }
            });
          })
        },
        uploadImgTo: function(id){
          var self = this;
          wx.uploadImage({
            localId: id, // 需要上传的图片的本地ID，由chooseImage接口获得
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {
              self.form.serverId = res.serverId;
            }
          });
           
        },
        remove: function (index) {
          this.status.selected = index;
          this.status.isDeleteImg = true;
        },
        onSureDelete: function(index){
           var self = this;
           var img = (this.imgs[index].img).split(this.domain);
            this.$http.post(this.domain+'/deleteBanner', {
              'image':img[1]
            }, {
              emulateJSON:true,
              headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res) {
              console.log(res.json());
              if (res.json().success == 1) {
                this.imgs.splice(index,1);
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  self.status.isDeleteImg = false;
                }, 300);
              } else {
                console.log(res.json().error);
              }
            }); 
        },
        onCancel: function(){
          this.status.isDeleteImg = false;
        }
      }
	});
})()