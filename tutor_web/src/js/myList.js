(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
    el: 'body',
    data: {
      timer: null,
      domain:'http://www.yinzishao.cn',
 	    msgList: [],
			status:{
        isList: true,
        isNoList: false,
				isLoading: true,
				isTutorInfo: false,
				isInvited: true,
				isReject: false,
				isSureRefuse: false,
				isSureAccept: false,
        isAccount: false,
				isUploadImg: false,
				isRemindTip: false,
        text: '',
        isSuccess: true,
        expection: false,
        isSubmit: false,
        isEnlargeImg: false,
        enlargeImg: '',
			},
			detailedList: [],
			form:{
				selected:'',
				isRegister: '',
        expection: '',
				isMsg: '',
				img: '',
			},
      para:{
        "start": 0,
        "size": 16
      },
      jsonData: [],
			config:{
	      width: 100,
	      height:100,
	      quality: 0.8
	    },
  },
  computed: {
    remindSubmit: function(){
      if(this.form.expection!==''&&this.form.expection!=null){
        return true;
      }else{
        return false;
      }
    },
    isOnSubmit: function(){
      if(this.form.img != ''){
        return true;
      }else{
        return false;
      }
    }
  },
  ready: function(){
   this.renderData();
 	 this.status.isLoading = false;
  },
  methods:{
    down: function(){
      this.para.size = 5;
      this.para.start++;
      if(this.jsonData.length!==0){
        this.renderData();
      }
    },
   	renderData: function(){
      this.$http.post(this.domain+'/getOrder', this.para,{
        crossOrigin: true,
        headers:{
          'Content-Type':'application/json' 
        }
      }).then(function(res){
        console.log(res.json());
        if(res.json().success == 0){
          console.log(res.json().error);
        }else{
          this.jsonData = res.json();
           var data = res.json();
           if(data.length!=0){
             for(var i = 0;i<data.length;i++){
              if(data[i].result == '您已拒绝'||data[i].result == '家长已拒绝'){
                data[i].isRed = true;
              }else{
                data[i].isRed = false;
              }
              if(data[i].screenshot_path!=null||data[i].screenshot_path!=''){
                data[i].screenshot_path = this.domain+data[i].screenshot_path;
              }
             }
             var json = this.msgList.concat(data);
             this.$set('msgList', json);
           }else{
              if(this.msgList.length == 0){
                this.status.isList = false;
                this.status.isNoList = true;
              }
           }
        }
      });
   	},
   	onReturn: function(){
   		window.location.href="./teacherMyPage.html";
   	},
    grade_level: function(key){
      switch(key){
        case 0:
          return '';
        case 1:
          return '较为靠后';
        case 2: 
          return '中等偏下';
        case 3:
          return '中等水平';
        case 4:
          return '中上水平';
        case 5: 
          return '名列前茅';
      }
    },
    onTutorInfo: function(index){
  	  this.form.selected = index;
      this.status.isTutorInfo = true;
      this.status.isSuccess = true;
      var list = this.msgList[index];
      if(list.result == '请上传截图'){
        this.status.isTutorInfo = false;
        this.status.isAccount = true;
      }else if(list.result == '对方已同意'){
        this.status.isTutorInfo = false;
        this.onAccept(index);
      }else if(list.result == '管理员审核中'){
        this.status.isTutorInfo = false;
        this.status.isRemindTip = true;
      }else{
        this.$http.post(this.domain+'/getParentInfo',{
          "pd_id": list.pd,
          "format": true,
        },{
          crossOrigin: true,
          headers:{
            'Content-Type':'application/json'  
          }
        }).then(function(res){
          console.log(res.json());
           if(res.json().success == 0){
             console.log(res.json().error);
           }else{
            var data = res.json();
            data.class_field=this.grade_level(data.class_field);
            this.detailedList = data;
           }
        });
        if(list.result == '对方已邀请'){
          this.status.isInvited = true;
          this.status.isReject = false;
        }
        else if(list.result == '已成交'){
          this.status.text = '双方已成交';
          this.status.isInvited = false;
          this.status.isReject = true;
        }else if(list.result == '家长已拒绝'){
          this.status.text = '再次报名该家长';
          this.status.isInvited = false;
          this.status.isReject = true;
        }else if(list.result == '您已拒绝'){
          this.status.text = '您已拒绝邀请';
          this.status.isInvited = false;
          this.status.isReject = true;
          this.status.isSuccess = false;
        }
        else if(list.result == '您已报名'){
          this.status.text = '取消报名';
          this.status.isInvited = false;
          this.status.isReject = true;
          this.status.isSuccess = false;
        }
      }      
  	},
    onStep: function(index){
      if(this.status.text=='再次报名该家长'){
        this.status.isTutorInfo = false;
        this.status.expection = true;
      }else if(this.status.text == '取消报名'){
        this.status.isTutorInfo = false;
        this.form.isMsg = '取消报名';
        this.status.isSureRefuse = true;
      }else if(this.status.text == '双方已成交' || this.status.text == '您已拒绝邀请'){
        this.status.isTutorInfo = false;
      }
    },
    onApply: function(index){
      if(this.form.expection!=""&&this.form.expection!=null){
        this.$http.post(this.domain+'/applyParent',{
          "pd_id": this.msgList[index].pd,
          "expectation": this.form.expection,
          "type": 1
         },{
             crossOrigin: true,
              headers:{
                'Content-Type':'application/json' 
              }
         }).then(function(res){
          console.log(res.json());
           if(res.json().success == 1){
            var self = this;
            this.timer && clearTimeout(this.timer);
            this.timer = setTimeout(function(){
              self.msgList[index].result='您已报名';
              self.msgList[index].isRed = false;
              self.msgList[index].finish = 0;
              self.status.expection = false;
              self.form.expection = '';
            }, 1000);
           }
        })
       }else{
        return false;
       }      
    },
		onAccept: function(index){
      this.$http.post(this.domain+'/handleOrder',{
        'accept': 1,
        'id': this.msgList[index].pd,
        'type': 0
      },{
        crossOrigin: true,
        headers:{
          'Content-Type':'application/json; charset=UTF-8' 
        }

      }).then(function(res){
        if(res.json().success == 1){
          this.msgList[index].finish = 0;
          this.msgList[index].isRed = false;
          this.msgList[index].result= '请上传截图';
          this.status.isTutorInfo = false;
          this.status.isAccount = true;
        }else{
          console.log(res.json().error);
        }
        
      })
		},
		onRefuse: function(){
      this.form.isMsg = '拒绝邀请';
      this.status.isTutorInfo = false;
			this.status.isSureRefuse = true;
		},
    onCloseExp:function(){
      this.status.expection = false;
    },
		onSureRefuse: function(index){
      var msg = this.form.isMsg;
      if(msg == '取消报名'){
        this.$http.post(this.domain+'/applyParent',{
          'pd_id': this.msgList[index].pd,
          'type': 0              
         },{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
         }).then(function(res){
           console.log(res.json());
           if(res.json().success == 1){
            var self = this;
            this.timer && clearTimeout(this.timer);
            this.timer = setTimeout(function(){
              self.status.isSureRefuse = false;
              self.msgList.splice(index,1);              
            }, 500);
           }else{
             conosle.log(res.json().error);
           } 
        })
      }else {
        //‘拒绝邀请’
        this.$http.post(this.domain+'/handleOrder',{
          'accept': 0,
          'id': this.msgList[index].pd,
          'type': 0
        },{
          crossOrigin: true,
          headers:{
            'Content-Type':'application/json' 
          }
        }).then(function(res){
          if(res.json().success == 1){
              this.msgList[index].result= '您已拒绝';
              this.msgList[index].isRed = true;
              this.msgList[index].finish = 1;
              this.status.isSureRefuse = false;
              this.status.isTutorInfo = false;
          }else{
            console.log(res.json().error);
          }        
        })
      }
		},
    onChangeImg: function(){
      this.status.isRemindTip = false;
      this.status.isAccount = true;
    },
		onCancel: function(){
			this.status.isSureRefuse = false;
		},
		onClose: function(){
			this.status.isTutorInfo = false;
		},
    onCloseAccount: function(){
      this.status.isAccount = false;
    },
		uploadPic: function(e){
      var self = this;
      var file = e.target.files[0];
      lrz(file, self.config)
          .then(function (rst) {              
            self.form.img=rst.base64;

          })
          .catch(function (err) {
              console.log(err)
              alert('压缩失败')
          })
          .always(function () {
              // 清空文件上传控件的值
              e.target.value = null
          });
	    },
	    onSubmitImg: function(index){
	    	this.$http.post(this.domain+'/uploadScreenshot',{
          'oa_id': this.msgList[index].oa_id,
          'pic': this.form.img
        },{
          crossOrigin: true,
          headers:{
            'Content-Type':'application/json' 
          }

        }).then(function(res){
          console.log(res.json());
          if(res.json().success == 1){
          	this.status.isAccount = false;
          	this.status.isRemindTip = true;
            this.msgList[index].isRed = false;
            this.msgList[index].screenshot_path = this.form.img;
            this.form.img = '';
            this.msgList[index].result= '管理员审核中';
          }else{
            console.log(res.json().error);
          }
        })
	    },
      showImg: function(index){
        this.status.enlargeImg = this.msgList[this.form.selected].screenshot_path;
        this.status.isEnlargeImg = true;
      },
      closeImg: function(){
        this.status.isEnlargeImg = false;
      },
	    onSureSubmit: function(index){            
        this.status.isRemindTip = false;
	    }
  }
	});
})();