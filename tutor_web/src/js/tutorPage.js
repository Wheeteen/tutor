(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
  var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        // domain: 'http://www.shendaedu.com/',
        domain: 'http://shaozi.beansonbar.cn/',
      	status:{
          timer: null,
          isParent: true,
          isNoParent: false,
          isRegister: '',
          isLoading: false,
      		myInfo: false,
      		isTutorInfo: false,
      		isDefault: '',
      		isSuccess: '',
          // getLocation: false,
          expection: false,
          isSubmit: false,
          isInfoTipOne: false,
          noExpection: '',
          errorTip:'对不起，您还未通过审核',
          overY: false
      	},
      	msgList: [],
        detailedList: [],
        para:{
          'size': 9,
          'start':0
        },
        jsonData:[],
      	form:{
      		selected: '',
          expection: '',
      	},
        location:{
          latitude:'',
          longitude:'',
          // speed:'',
          // accuracy:'',
        },
        signature: '',
      },
      computed:{
       remindSubmit: function(){
          if(this.form.expection!==''&&this.form.expection!=null){
            return true;
          }else{
            return false;
          }
        },
      },
      ready: function(){
      	this.getData();
        this.status.isLoading = true; 
        this.getSignature();             
      },
      methods:{
        down: function(){
          this.para.size = 5;
          this.para.start++;
          console.log(this.jsonData);
          if(this.jsonData.length!==0){
            this.getData();
          }          
        },
      	getData:function(){
         var self = this;
    		 this.$http.post(this.domain+'getParentOrder',this.para,{
               crossOrigin: true,
               headers:{
                  'Content-Type':'application/json; charset=UTF-8' 
               }
          }).then(function(res){
            console.log(res.json());
            if(res.json().success == 0){
              console.log(res.json().error);
            }else{
              this.jsonData = res.json();
              var data = res.json();
              if(data.length!=0){
                for(var i=0;i<data.length;i++){
                  if(data[i].distance!==0){
                    data[i].distance = data[i].distance.toFixed(2);
                  }
                  var level=this.grade_level(data[i].class_field);
                  data[i].class_field = level;
                  if(data[i].isInvited == '您已拒绝'||data[i].isInvited == '家长已拒绝'||data[i].isInvited == '您未按时上传截图'){
                    data[i].isRed = true;
                  }else{
                    data[i].isRed = false;
                  }
                }
                var json=self.msgList.concat(data);
                this.$set('msgList',json); 
              }else{
                if(this.msgList.length==0){
                  this.status.isParent = false;
                  this.status.isNoParent = true;
                }
              }
              
            }    
          })
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
        getSignature: function(){        
          this.$http.post(this.domain+'generate_signature',{
            "timestamp": 1482652615,
            "nonceStr": 'yinzishao',
          },{
            crossOrigin:true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            console.log(res.json());
            if(res.json().success == 1){
              this.signature = res.json().signature;
              var self = this;
              wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: 'wx7a327445ac3309b4', // 必填，公众号的唯一标识
                timestamp: 1482652615, // 必填，生成签名的时间戳
                nonceStr:'yinzishao' , // 必填，生成签名的随机串
                signature: self.signature,// 必填，签名，见附录1
                jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
              });
              // this.timer && clearTimeout(this.timer);
              // this.timer = setTimeout(function(){
              //  self.onAllow();
              // }, 300);
            }else{
              console.log(res.json().error);
            }
            
          })                
        },
        sendLocation: function(){
          this.$http.post(this.domain+'setLocations',this.location,{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            if(res.json().success == 1){
              // this.status.getLocation = false;
              this.para.start =0;
              this.para.size = 9;
              this.msgList = [];
              this.getData();
            }
          })
        },
        setLocation: function(){
          // if(this.getSignature==''){
          //   this.getSignature();
          // }else{
          this.onAllow();
          // }
        },
        //发送定位
        onAllow: function(){
          var self = this;
          wx.ready(function (){
            wx.getLocation({
              type: 'wgs84',
              success: function (res) {
                self.location.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                self.location.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                self.sendLocation();
              },
              
            });
          })
          
        },
      	onRecommend:function(){
      		this.status.tutorList = true;
      		this.status.myInfo = false;
      	},
      	onMine:function(){
      		window.location.href="./teacherMyPage.html";
      	},
      	onTutorInfo: function(index){
          this.status.overY = true;
      		this.form.selected = index;
      		this.status.isTutorInfo = true;
          this.status.isDefault = false;
          this.status.isSuccess = true;
          this.detailedList = this.msgList[index];
          switch(this.detailedList.isInvited){
            case '您已报名':
              this.status.isDefault = true;
              this.status.isSuccess = false;
              this.status.isRegister = "取消报名";
              break;
            case '对方已邀请':
              this.status.isRegister = "该家长已邀请";
              break;
            case '对方已同意':
              this.status.isRegister = "该家长已同意";
              break;
            case '您已拒绝':
              this.status.isDefault = true;
              this.status.isSuccess = false;
              this.status.isRegister = "您已拒绝该家长";
              break;
            case '您未按时上传截图':
              this.status.isDefault = true;
              this.status.isSuccess = false;
              this.status.isRegister = "您未按时上传截图";
              break;
            case '家长已拒绝':
              this.status.isDefault = true;
              this.status.isSuccess = false;
              this.status.isRegister = "该家长已拒绝";
              break;
            case '请上传截图':
              this.status.isRegister = '请到“我的订单”上传截图';
              break;
            case '管理员审核中':
              this.status.isRegister = "管理员审核中";
              break; 
            case '已成交':
              this.status.isRegister = "双方已成交";
              break; 
            case '':
              this.status.isRegister = "报名";
              break; 
          }      		
      	},
      	onClose: function(){
      	    this.status.isTutorInfo = false;
            this.status.overY = false;
      	},
      	onRegister: function(index){
      	  if(this.status.isRegister == "取消报名"){
             this.$http.post(this.domain+'applyParent',{
              'pd_id': this.msgList[index].pd_id,
              'type': 0              
             },{
                crossOrigin: true,
                headers:{
                  'Content-Type':'application/json' 
                }
             }).then(function(res){
               console.log(res.json());
               this.status.overY = false;
               if(res.json().success == 1){
                this.status.isRegister ='取消成功';
                var self = this;
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  self.msgList[index].isInvited='';
                  self.status.isTutorInfo = false;
                }, 400);
               }else{
                 conosle.log(res.json().error);
               }
               
             })
          }else if(this.status.isRegister == "报名"){
            this.status.isTutorInfo = false;
            this.status.expection = true;
          }
          else {
            this.status.isTutorInfo = false;
            return false;
          }       
      	},
        onApply: function(index){
          if(this.form.expection!=""&&this.form.expection!=null){
            this.status.isSubmit= true;
            this.$http.post(this.domain+'applyParent',{
              "pd_id": this.msgList[index].pd_id,
              "expectation": this.form.expection,
              "type": 1
             },{
                 crossOrigin: true,
                  headers:{
                    'Content-Type':'application/json' 
                  }
             }).then(function(res){
              console.log(res.json());
              this.status.overY = false;
              var self = this;
              this.status.isSubmit = false;
              if(res.json().success == 1){              
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  self.msgList[index].isInvited='您已报名';
                  self.status.expection = false;
                  self.form.expection = '';
                }, 400);
              }else{
                 console.log(res.json().error);
                  this.status.errorTip = res.json().error;
                  this.status.isTutorInfo = false;
                  this.status.isInfoTipOne = true;
                  self.status.expection = false;
                  this.timer && clearTimeout(this.timer);
                  this.timer=setTimeout(function(){
                    self.status.isInfoTipOne = false;
                  },1000);
              }
            })
          }else{
            return false;
          }
          
        },
        onCloseExp: function(){
          this.status.overY = false;
          this.status.expection = false;
        }
      }
  });
})();