(function(){
  var id=window.localStorage.getItem("id");
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el:'body',
      data:{
        domain:'http://www.yinzishao.cn/',
      	msgList:[
          // {'msg_id':1,'message_title':'张先生已接受您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':2,'message_title':'张先生已拒绝您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':3,'message_title':'张先生已报名了您的请求','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':4,'message_title':'好学吧家教服务平台邀请您填写反馈意见啦','status':false},
          // {'msg_id':5,'message_title':'张先生已接受您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':6,'message_title':'张先生已拒绝您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':7,'message_title':'张先生已报名了您的请求','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':8,'message_title':'好学吧家教服务平台邀请您填写反馈意见啦','status':false},
          // {'msg_id':9,'message_title':'张先生已接受您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':10,'message_title':'张先生已拒绝您的报名','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':11,'message_title':'张先生已报名了您的请求','message_content':'张先生已接受您的报名,请到“我的老师”处查看详细信息','status':false,'isDetailed':false},
          // {'msg_id':12,'message_title':'好学吧家教服务平台邀请您填写反馈意见！','status':false},  
      	],
      	status:{
      		isFeedBack: false,
          isLoading: true,
          isSubmit: false,
          isParent: '',
          isMsg: true,
          isNoMsg: false,
          selected: ''
      	},
        para:{
          'size': 22,
          'start':0
        },
        jsonData:[],
      	form:{
      		'tutorservice': '',
      		'appservice': '',
      		'rate': Number
      	},
      	xingList:[
          {key:false},{key:false},{key:false},{key:false},{key:false}
      	]
      },
      computed: {
        remindSubmit: function(){
          if(this.form.tutorservice != ''&&this.form.appservice != ''&&this.form.rate !== Number){
            return true;
          }else{
            return false;
          }
        }
      },
      
      ready: function(){
        this.renderData();
        var param = this.getParam();
        if(param == 'parent'){
          this.status.isParent = true;
        }else{
          this.status.isParent = false;
        }
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
          this.$http.post(this.domain+'getMsg', this.para,{
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
              if(data.length!==0){
                var json=this.msgList.concat(data);
                this.$set('msgList',json);
              }
              else{
                if(this.msgList.length==0){
                  this.status.isMsg = false;
                  this.status.isNoMsg = true;
                } 
              }             
            }
          });
        },
        getParam: function(){
           var str = location.search;
           str = str.substr(1,str.length);
           return str;
        },
      	onShow:function(index){
          this.status.selected = index;
          if(this.msgList[index].status == false){
            this.$http.post(this.domain+'readMessage',{
              'msg_id': this.msgList[index].msg_id
            },{
              crossOrigin: true,
              headers:{
                'Content-Type':'application/json' 
              }

            }).then(function(res){
              console.log(res.json());
              if(res.json().success == 1){
                this.msgList[index].status = true;
                if(this.msgList[index].message_title=='好学吧家教邀请您填写反馈意见！'){
                  this.status.isFeedBack = true;
                }else{
                  this.msgList[index].isDetailed = !this.msgList[index].isDetailed;
                }
              }
            })
          }else{
            if(this.msgList[index].message_title=='好学吧家教邀请您填写反馈意见！'){
              if(this.msgList[index].isFeedBack == true){
                this.msgList[index].message_content = '您已填写！';
                this.msgList[index].isDetailed = true;
              }else{
                this.status.isFeedBack = true;
              }             
            }else{
              this.msgList[index].isDetailed = !this.msgList[index].isDetailed; 
            }
          }
      		
      	},
      	onReturn: function(){
          var param = this.getParam();
          if(param == 'teacher'){
            window.location.href="./teacherMyPage.html";
          }else{
            window.location.href="./parentMyPage.html";
          }
      		
      	},
      	onXing: function(index){
      		this.form.rate = index+1;
      		for(var i=0;i<=index;i++){
      			this.xingList[i].key = true;
      		}
      		for(var j =index+1;j<5;j++){
                this.xingList[j].key = false;
      		}
      	},
      	onFeedback: function(){
          if(this.form.rate!== Number&&this.form.tutorservice!=''&&this.form.appservice!=''){
            this.status.isSubmit = true;
            this.$http.post(this.domain+'submitFeedBack', this.form, {
              crossOrigin:true,
              headers:{
                'Content-Type':'application/json' 
              }
            }).then(function(res) {
              console.log(res.json());
              this.status.isSubmit = false;
              if (res.json().success == 1) {
                this.msgList[this.status.selected].isFeedBack = true;
                this.status.isFeedBack = false;
              }else {
                console.log(res.json().error);
              }
            });
          }else{
            return false;
          }
      	},
      	onClose: function(){
      		this.status.isFeedBack = false;

      	}
      }
	});
})();