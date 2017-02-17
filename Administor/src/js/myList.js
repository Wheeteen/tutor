(function(){
	Vue.http.interceptors.push(function(request, next){
		request.credentials = true;
		next();
	});
	var vm = new Vue({
       el: 'body',
       data: {
         	domain:'http://www.yinzishao.cn:8000',
         	timer: null,
       	    tutorList:[
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已邀请',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已报名',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已拒绝',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               // {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},  
               {"oa_id": 19,"pd": 50,"tea": 8,"name": "李素","result": "您已邀请","finish": 0,"type": "parent"},//取消邀请，之后直接删掉
               {"oa_id": 20,"pd": 50,"tea": 8,"name": "李素","result": "老师已拒绝","finish": 1,"type": "parent"},//老师拒绝(老师直接拒绝或者是半小时内没有上传截图)，“再次邀请老师”
               {"oa_id": 21,"pd": 50,"tea": 8,"name": "李素","result": "管理员审核中","finish": 0,"type": "parent"}, //老师同意，还没有上传截图，或者管理员还没有审核
               {"oa_id": 22,"pd": 50,"tea": 8,"name": "李素","result": "已成交","finish": 1,"type": "parent"}, //老师同意，已经上传截图，管理员审核完
               {"oa_id": 23,"pd": 50,"tea": 8,"name": "李素","result": "向您报名","finish": 0,"type": "teacher"}, //家长“接受报名”，“拒绝报名”
               {"oa_id": 24,"pd": 50,"tea": 8,"name": "李素","result": "您已同意","finish": 0,"type": "teacher"}, //家长同意老师的报名，同意之后取消同意变为“已拒绝”
               {"oa_id": 25,"pd": 50,"tea": 8,"name": "李素","result": "管理员审核中","finish": 0,"type": "teacher"}, //家长同意老师的报名，老师还没有上传截图
               {"oa_id": 26,"pd": 50,"tea": 8,"name": "李素","result": "已成交","finish": 1,"type": "teacher"}, //家长同意老师的报名，老师已经上传截图
               {"oa_id": 27,"pd": 50,"tea": 8,"name": "李素","result": "已拒绝","finish": 1,"type": "teacher"} //家长拒绝老师的报名，还可以再次“接受报名”
			],
			status:{
				isTutor: true,
				isNoTutor: false,
                isTutorInfo: false,
                isSuccess: true,
                isChangeInfo: false,
                // isDefault: '',
                isInfoTipOne: false,
                selected: '',
                isRegister: '',
                isLoading: false,
                onParent: true,
                onTeacher: false,
                errorTip:'对不起，您只能选择一位老师'
			},
			para:{
		        'start': 0,
		        'size': 16
		    },
		    jsonData:[],
			detailedList: [],
			form:{
				selected:'',
				isRegister: '',
				isMsg: '',
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
          this.$http.post(this.domain+'/getOrder',this.para,{
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
          	  if(data.length !=0){
          	   for(var i = 0;i<data.length;i++){
          	   	if(data[i].result == '您已拒绝'||data[i].result == '老师已拒绝'){
          	   		data[i].isRed = true;
          	   	}else{
          	   		data[i].isRed = false;
          	   	}
          	   }
               var json = this.tutorList.concat(data);
               this.$set('tutorList', json);
          	  }else{
          	  	if(this.tutorList.length == 0){
          	  	  this.status.isTutor = false;
   			      this.status.isNoTutor = true;
          	  	}
          	  }
          	}
          });
       	},
       	onReturn: function(){
       		window.location.href="./other.html";
       	},
       	onTutorInfo: function(index){
       		this.detailedList=[];
			this.status.isTutorInfo = true;
			this.form.selected = index; 
			var list = this.tutorList[index];
			this.$http.post(this.domain+'/getTeacherInfo',{
				"tea_id": list.tea,
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
				 	if(data.certificate_photo!=''||data.certificate_photo!=null){
				 		data.certificate_photo=this.domain+data.certificate_photo;
				 	}
				 	var photo=data.teach_show_photo,len = photo.length;
				 	if(len>0){
                       for(var i=0;i<len;i++){
                       	photo[i]=this.domain+photo[i];
                       }
				 	}
				 	if(list.expectation!=null||list.expectation!=''){
				      data.expectation=list.expectation;
				    }  
				    this.detailedList = data; 
				 }
			});
			this.status.onParent = true;
			this.status.onTeacher = false;
            this.status.isSuccess = true;
			if(list.result == '管理员审核中'){
                this.form.isRegister = "管理员审核中";
			}else if(list.result == '已成交'){
			   this.form.isRegister = "双方已成交";
			}else if(list.result == '您已邀请'){
                this.status.isSuccess = false;
                this.form.isRegister = "取消邀请";
			}else if(list.result == '您已拒绝'){
			    this.status.isSuccess = false;
                this.form.isRegister = "您已拒绝该老师";
			}else if(list.result == '老师已拒绝'){
                this.form.isRegister = "再次邀请该老师";
			}
			else if(list.result == '向您报名'){
				this.status.onParent= false;
				this.status.onTeacher = true;
			}else if(list.result == '您已同意'){
	            this.status.isSuccess = false;
	            this.form.isRegister = "拒绝选择该老师";
	        }
		},
		onRegister1: function(index){
           if(this.form.isRegister == "取消邀请"){
           	  this.form.isMsg = '邀请';
           	  this.status.isTutorInfo = false;
           	  this.status.isChangeInfo = true;
			}else if(this.form.isRegister == '再次邀请该老师'){
				this.$http.post(this.domain+'/inviteTeacher',{
					'tea_id': this.tutorList[index].tea,
					'type': 1
				},{
					crossOrigin: true,
					headers:{
						'Content-Type':'application/json'	
					}

				}).then(function(res){
					console.log(res.json());
					if(res.json().success==1){
				       this.form.isRegister = '您已邀请';
				       this.tutorList[index].finish = 0;				       
		                var self = this;
		                this.timer && clearTimeout(this.timer);
		                this.timer = setTimeout(function(){
		                 self.tutorList[index].result = '您已邀请';
		                 self.tutorList[index].isRed = false;
				         self.status.isTutorInfo = false;
		                }, 1500);
					}else{
						console.log(res.json().error);
						var self = this;
						this.status.errorTip = res.json().error;
						this.status.isTutorInfo = false;
						this.status.isInfoTipOne = true;
						this.timer && clearTimeout(this.timer);
						this.timer=setTimeout(function(){
                           self.status.isInfoTipOne = false;
						},2000);
					}
					
				})
			}else if(this.form.isRegister == '拒绝选择该老师'){
				this.status.isTutorInfo = false;
				this.form.isMsg = '信息';
				this.status.isChangeInfo = true;
			}else{
				this.status.isTutorInfo = false;
				return false;
			}
		},
		//选择该老师
		onSelect: function(index){
          this.$http.post(this.domain+'/handleOrder',{
				'type': 1,
				'id': this.tutorList[index].tea,
				'accept': 1
			},{
				crossOrigin: true,
				headers:{
					'Content-Type':'application/json'	
				}

			}).then(function(res){
				if(res.json().success==1){
					var self = this;
				    this.timer && clearTimeout(this.timer);
		            this.timer = setTimeout(function(){
		              self.status.isTutorInfo = false;
		              self.tutorList[index].result = "您已同意"; 
		              self.tutorList[index].isRed = false;             
		            }, 1000);
				}else{
					console.log(res.json().error);
				}
			})
		},
		//拒绝该老师
		onRefuse: function(index){
          this.$http.post(this.domain+'/handleOrder',{
				'type': 1,
				'id': this.tutorList[index].tea,
				'accept': 0
			},{
				crossOrigin: true,
				headers:{
					'Content-Type':'application/json'	
				}

			}).then(function(res){
				console.log(res.json());
			    if(res.json().success==1){
					var self = this;
					this.tutorList[index].finish = 1;
				    this.timer && clearTimeout(this.timer);
		            this.timer = setTimeout(function(){
		              self.status.isTutorInfo = false;
		              self.tutorList[index].result = "您已拒绝";  
		              self.tutorList[index].isRed = true;            
		            }, 1000);
				}else{
					console.log(res.json().error);
				}
			})
		},
		onSureChange: function(index){
			var msg = this.form.isMsg;
			if(msg == '邀请'){
				this.$http.post(this.domain+'/inviteTeacher',{
					'tea_id': this.tutorList[index].tea,
					'type': 0
				},{
					crossOrigin: true,
					headers:{
						'Content-Type':'application/json'	
					}

				}).then(function(res){
					console.log(res.json());
					if(res.json().success==1){
						var self = this;
					    this.timer && clearTimeout(this.timer);
			            this.timer = setTimeout(function(){
			              self.status.isChangeInfo = false;
			              self.tutorList.splice(index,1);              
			            }, 300);
					}else{
						console.log(res.json().error);
					}
					
				})
			}else{
				this.$http.post(this.domain+'/handleOrder',{
					'type': 1,
				    'id': this.tutorList[index].tea,
				    'accept': 0
				},{
					crossOrigin: true,
					headers:{
						'Content-Type':'application/json'	
					}

				}).then(function(res){
					console.log(res.json());
					if(res.json().success==1){
						this.status.isChangeInfo = false;
					    this.tutorList[index].result = '您已拒绝';
					    this.tutorList[index].isRed = true; 
					    this.tutorList[index].finish = 1;
					}else{
						console.log(res.json().error);
					}
				})
			}
			
		},
		onClose: function(){
			this.status.isChangeInfo = false;
			this.status.isTutorInfo = false;
			this.status.isInfoTipOne = false;
		},
       }
	});
})();