(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        domain: 'http://www.yinzishao.cn:8000',
        status:{
  	  	  isUser: false,
  	  	  isDeal: true,
  	  	  isOther: false,
          isLoading: false,
          isUploadImg: false,
          isDeleteImg: false,
          selected: '',
      	},
      	config: {
          width: 375,
          height: 150,
          quality: 0.9
        },
        imgs: [],
        form: {
          image: '',
          url: ''
        }
      },
      ready: function(){
      	this.render();
        this.status.isLoading = true;
      },
      methods: {
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
          if(this.imgs.length>=5){
            return false;
          }else{
            this.status.isUploadImg = true;
          }         
        },
        onSubmitImg: function(index){
            if(this.form.image!== ''){
              this.$http.post(this.domain+'/changeText', this.form, {
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
                  this.form.url = '';
                } else {
                
                }
              }); 
            }else{
              return false;
            }
           
        },
        uploadPic: function (e) {
            var self = this
            var file = e.target.files[0]
            lrz(file, self.config)
              .then(function (rst) {
                  self.form.image = rst.base64;
                  // self.imgs.push(rst.base64)
              })
              .catch(function (err) {
                  console.log(err)
                  alert('压缩失败')
              })
              .always(function () {
                  // 清空文件上传控件的值
                  e.target.value = null
              })
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