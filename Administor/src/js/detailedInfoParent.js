(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data:{
      	timer: null,
        domain: 'http://www.yinzishao.cn:8000',
      	status:{
      		isSelecting: true,
	        isLoading: false,
	        isTutorInfo: false,
	        selected: '',
	        isRemindTeacher: false,
          isList: true,
          isNoList: false,
          text: '删除该请求'
      	},
      	detailedList:{
      		pd_id:0,
      		name:'张先生',
      		teacher_sex: '不限',
          learning_phase: '高中',
      		aim:'提高成绩',
      		subject:'数学',
          subject_other: '',
      		grade:'高一',
      		address:"大学城小洲",
      		time:"周六上午",
      		class_field: '成绩优良',
      		teacher_method:"nice,细心",
          teacher_method_other: '',
      		require:"上课要耐心细致，对孩子好",
      		salary: '18/h',
      		bonus: '100/月',
      		deadline: '2016年12月23号',
      		tel: '1234567891'
      	},
      	msgList:[
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已邀请',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已报名',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已拒绝',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'},
           // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[],tel:'18826103726'}, 
		    ],
        jsonData: [],
      	msgDetailedList: [],
        start: 0,
      	msg: {
      		text: '已发送请求'
      	}
      },
      ready: function(){
          this.renderTutor();
          this.renderOrderData();
          this.status.isLoading = true;
      },
      methods: {
        down: function(){
          this.start++;
          if(this.jsonData.length!==0){
            this.renderOrderData();
          }
        },
      	renderOrderData: function(){
          this.status.isSelecting = true;
          var id = parseInt(this.getParam('listId'));
          this.$http.post(this.domain+'/getUserOrders',{
            "id":id,
            "user":"parent",
            "start":this.start,
            "size":6
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
              this.jsonData = res.json();
              var data = res.json();
              if(data.length!=0){
                for(var i = 0;i<data.length;i++){
                  if(data[i].result == '已拒绝'||data[i].result == '老师已拒绝'){
                    data[i].isRed = true;
                  }else{
                    data[i].isRed = false;
                  }
                 }
                var json=this.msgList.concat(res.json());
                this.$set('msgList',json);
                this.status.isSelecting = false;
              }else{
                if(this.msgList.length==0){
                  this.status.isNoList = true;
                  this.status.isList = false;
                }
              }
            }
          });
		    },
		    getParam: function(param) {   //获取url上的参数
          var str = location.search;
          if (str.indexOf("?") == -1) return '';
          str = str.substr(1, str.length).split("&");
          for (var i = 0, cell, length = str.length; i < length; i++) {
            cell = str[i].split('=');
            if (cell[0] == param) {
              return cell[1];
            }
          }
        },
  	    renderTutor: function(){
  	      var id = parseInt(this.getParam('listId'));
  	      this.$http.post(this.domain+'/getInfo',{
              'id': id,
              'format': true,
              'user': 'parent'
          },{
          crossOrigin: true,
        	headers:{
            'Content-Type':'application/json' 
          }
        }).then(function(res){
        	console.log(res.json());
          if(res.json().sucess == 0){
            console.log(res.json().error);
          }else{
            this.$set('detailedList',res.json());
          }
        });
  	    },
        onReturn: function(){
          var searchWord = this.getParam('keyword');
          // if(searchWord !== ''){
          //   searchWord = encodeURIComponent(searchWord);
          // }
          // console.log(searchWord);
          window.location.href = './userAdministor.html?user=parent&keyword='+searchWord;
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
      	onChangeRequest: function(index){
      		window.location.href='./parentQuestion.html?changeInfoId='+index;
      	},
      	onRemindParent: function(index){
      		this.status.isRemindTeacher = true;
          var self = this;
      		this.timer && clearTimeout(this.timer);
    			this.timer = setTimeout(function(){
    				self.status.isRemindTeacher = false;
    			}, 1000);
      		if(this.msg.text=='已发送请求'){
      			this.$http.post(this.domain+'/remindFeedBack',{
	              'id': index,
	              'user':'parent',
	            },{
                crossOrigin: true,
	              headers:{
	                'Content-Type':'application/json; charset=UTF-8' 
	              }
	            }).then(function(res){
                console.log(res.json());
	              if(res.json().success == 1){
	              	this.msg.text = '请勿重复发送请求';
	              }
	            })
      		}
      	},
      	onDetailedInfo: function(index){
           this.status.selected = index;
           this.status.text = '删除该请求';
           this.msgDetailedList = [];
           var list = this.msgList[index];
           this.$http.post(this.domain+'/getTeacherInfo',{
              "tea_id": list.tea,
              "format": true,
            },{
              crossOrigin: true,
              headers:{
                'Content-Type':'application/json'  
              }
            }).then(function(res){
               if(res.json().success == 0){
                console.log(res.json().error);
               }else{
                var data = res.json();
                if(data.certificate_photo!=''||data.certificate_photo!=null){
                  data.certificate_photo=this.domain+data.certificate_photo;
                }
                var photo=data.teach_show_photo,len = photo.length;
                if(len>0){
                 for(var i=0;i<len;i++){
                  photo[i]=this.domain+photo[i];
                 }
                }
                this.msgDetailedList = data;
                this.status.isTutorInfo = true;
               }
            })
           
      	},
      	onDelete: function(index){        	
      		this.$http.post(this.domain+'/deleteOrder',{
              'oa_id': this.msgList[index].oa_id,
            }, {
            crossOrigin: true,
    				headers:{
              'Content-Type':'application/json' 
            } 
    			}).then(function(res) {
    				if (res.json().success == 1) {
              var self = this;
              this.status.text = '该请求已删除';
              this.timer && clearTimeout(this.timer);
              this.timer = setTimeout(function(){
                self.msgList.splice(index,1);
                self.status.isTutorInfo = false;
              }, 800);
    				}else{
              console.log(res.json().error);
            }
    				
    			});        
        },
        onClose: function(){
        	this.status.isTutorInfo = false;
        }
      },
	});
})();