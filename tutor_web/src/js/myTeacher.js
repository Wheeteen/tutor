(function(){
	Vue.http.interceptors.push(function(request, next){
		request.credentials = true;
		next();
	});
	var vm = new Vue({
       el: 'body',
       data: {
         	domain:'http://shaozi.beansonbar.cn',
         	timer: null,
       	    tutorList:[],
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
                isEnlargeImg: false,
                enlargeImg: '',
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
       		window.location.href="./parentMyPage.html";
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
				 	if(data.certificate_photo!=''&&data.certificate_photo!=null){
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
                this.status.isSuccess = true;
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
		showImg: function(index){
          this.status.enlargeImg = this.detailedList.teach_show_photo[index];
          this.status.isEnlargeImg = true;
		},
		closeImg: function(){
           this.status.isEnlargeImg = false;
		},
		onClose: function(){
			this.status.isChangeInfo = false;
			this.status.isTutorInfo = false;
			this.status.isInfoTipOne = false;
		},
       }
	});
})();