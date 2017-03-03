(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
  var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        domain: 'http://www.yinzishao.cn/',
      	status:{
          isParent: true,
          isNoParent: false,
          isRegister: '',
          isLoading: false,
      		myInfo: false,
      		isTutorInfo: false,
      		isDefault: '',
      		isSuccess: '',
          getLocation: false,
          expection: false,
          isSubmit: false,
          isInfoTipOne: false,
          noExpection: '',
          errorTip:'对不起，您还未通过审核'
      	},
      	msgList: [
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:1,name:'张先生',distance:0.8,isInvited: '已接受',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:2,name:'张先生',distance:0.8,isInvited: '已拒绝',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:3,name:'张先生',distance:0.8,isInvited: '已完成',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:4,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
          // {pd_id:0,name:'张先生',distance:0.8,isInvited: '已报名',teacher_sex: '不限', learning_phase: '高中',aim:'提高成绩',subject:'数学',subject_other: '',grade:'高一',address:"大学城小洲",time:"周六上午",class_field: '成绩优良',teacher_method:"nice,细心", teacher_method_other: '',require:"",salary: '18/h', bonus: '100/月',deadline:'2017-01-12',create_time: '2016.12.28 16:59'},
      	],
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
                  var level=this.grade_level(data[i].class_field);
                  data[i].class_field = level;
                  if(data[i].isInvited == '您已拒绝'||data[i].isInvited == '家长已拒绝'){
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
        // configuration: function(){
        //   var self = this;
        //   wx.config({
        //     debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        //     appId: 'wx6fe7f0568b75d925', // 必填，公众号的唯一标识
        //     timestamp: 1482652615, // 必填，生成签名的时间戳
        //     nonceStr:'yinzishao' , // 必填，生成签名的随机串
        //     signature: self.signature,// 必填，签名，见附录1
        //     jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
        //   });
        // },
        getSignature: function(){        
          this.$http.post(this.domain+'/generate_signature',{
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
                debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: 'wx6fe7f0568b75d925', // 必填，公众号的唯一标识
                timestamp: 1482652615, // 必填，生成签名的时间戳
                nonceStr:'yinzishao' , // 必填，生成签名的随机串
                signature: self.signature,// 必填，签名，见附录1
                jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
              });
              this.status.getLocation = true;
            }else{
              console.log(res.json().error);
            }
            
          })                
        },
        sendLocation: function(){
          this.$http.post(this.domain+'/setLocations',this.form,{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }
          }).then(function(res){
            if(res.json().success == 1){
              this.status.getLocation = false;
            }
          })
        },
        setLocation: function(){
          // this.status.getLocation = true;
          this.getSignature();
          // this.configuration();
          // this.wxReady();
        },
        //发送定位
        onAllow: function(){
          var self = this;
          wx.getLocation({
            type: 'wgs84',
            success: function (res) {
              alert(JSON.stringify(res));
              self.form.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
              self.form.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
              // self.form.speed = res.speed; // 速度，以米/每秒计
              // self.form.accuracy = res.accuracy; // 位置精度
              this.sendLocation();
              console.log("latitude : "+self.form.latitude+"--longitude : "+self.form.longitude+"--speed : "+self.form.speed+"--accuracy : "+self.form.accuracy);
            }
          });
            
        },
        onCancel: function(){
          this.status.getLocation = false;
        },
      	onRecommend:function(){
      		this.status.tutorList = true;
      		this.status.myInfo = false;
      	},
      	onMine:function(){
      		window.location.href="./teacherMyPage.html";
      	},
      	onTutorInfo: function(index){
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
               if(res.json().success == 1){
                this.status.isRegister ='取消成功';
                var self = this;
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  self.msgList[index].isInvited='';
                  self.status.isTutorInfo = false;
                }, 1000);
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
              var self = this;
              this.status.isSubmit = false;
              if(res.json().success == 1){              
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  self.msgList[index].isInvited='您已报名';
                  self.status.expection = false;
                  self.form.expection = '';
                }, 1000);
              }else{
                 console.log(res.json().error);
                  this.status.errorTip = res.json().error;
                  this.status.isTutorInfo = false;
                  this.status.isInfoTipOne = true;
                  this.timer && clearTimeout(this.timer);
                  this.timer=setTimeout(function(){
                    self.status.isInfoTipOne = false;
                  },2000);
              }
            })
          }else{
            return false;
          }
          
        },
        onCloseExp: function(){
          this.status.expection = false;
        }
      }
  });
})();