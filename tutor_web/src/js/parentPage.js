(function(){
	Vue.http.interceptors.push(function(request, next){
		request.credentials = true;
		next();
	});
	var vm = new Vue({
		el: 'body',
		data:{
			domain: 'http://www.yinzishao.cn:8000',
			status:{
                isTutorInfo: false,
                isSuccess: '',
                isDefault: '',
                isInfoTipOne: false,
                selected: '',
                isRegister: '',
                isLoading: false,
                errorTip:'对不起，您只能选择一位老师',
                getLocation: false,
                isTutor: true,
                isNoTutor: false
			},
			recommendList:[
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已邀请',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已报名',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已拒绝',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'已完成',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},
               {tea_id: 1,certificate_photo:'../img/user02.png',name:'张老师',isInvited:'',subject:'数学',subject_other:'',grade:'高一',distance:0.6,native_place:"天河",time:"周六上午",place:"家长家",teacher_method:"nice,细心",teacher_method_other: '',expection:"上课要耐心细致",sex:'男',salary_bottom:20,salary_top:60,campus_major:'数学',score:'学习成绩进步很大',self_comment:'特别受学生喜欢',teach_show_photo:[]},  
			],
			detailedList:[],
			jsonData:[],
			form: {
			  'size':9,
			  'start':0
			},
			location:{
	          latitude:'',
	          longitude:'',
	          speed:'',
	          accuracy:'',
	        },
	        signature: '',
		},
		ready: function(){
			this.renderData();
			this.status.isLoading = true;
		},
		methods:{
			down: function(){
              this.form.start++;
              if(this.jsonData.length!==0){
	            this.renderData();
	          }
			},
	        renderData: function(){
	        	this.$http.post(this.domain+'/',this.form,{
	               crossOrigin: true,
	               headers:{
	                  'Content-Type':'application/json' 
	               }
	            }).then(function(res){
	              if(res.json().success == 0){
	              	console.log(res.json().error);
	              }else{
	              	this.jsonData = res.json();
	              	var data = res.json();
	              	if(data.length!=0){
	              		for(var i = 0;i<data.length;i++){
		              		if(data[i].certificate_photo!=''){
		              			data[i].certificate_photo = this.domain+data[i].certificate_photo;
		              		}else{
		              			data[i].certificate_photo = '../img/user02.png';
		              		}
		              		var teach_photo=data[i].teach_show_photo,len=data[i].teach_show_photo.length;
		              		for(var j=0;j<len;j++){
	                           teach_photo[j]=this.domain+teach_photo[j];
		              		}
		              	}
		              	var json=this.recommendList.concat(data);
		                this.$set('recommendList',json);
	              	}else{
	              		if(this.recommendList.length==0){
						  this.status.isNoTutor = true;
						  this.status.isTutor = false;
						}
	              	}   
	              }
	            });
	        },
	        configuration: function(){
	          var self = this;
	          wx.config({
	            debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	            appId: 'wx6fe7f0568b75d925', // 必填，公众号的唯一标识
	            timestamp: 1482652615, // 必填，生成签名的时间戳
	            nonceStr:'yinzishao' , // 必填，生成签名的随机串
	            signature: self.signature,// 必填，签名，见附录1
	            jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	          });
	        },
	        getSignature: function(){        
	          this.$http.post(this.domain+'/',{
	            timestamp: 1482652615,
	            nonceStr: 'yinzishao',
	          },{
	            emulateJSON:true,
	            crossOrigin: true,
	            headers:{
	              'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8' 
	            }
	          }).then(function(res){
	            this.signature = res.json().signature;
	          })                
	        },
	        wxReady: function(){
	          var self = this;
	          wx.ready(function(){
	          //地理位置
	            wx.getLocation({
	              type: 'wgs84',
	                success: function (res) {
	                  self.form.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	                  self.form.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	                  self.form.speed = res.speed; // 速度，以米/每秒计
	                  self.form.accuracy = res.accuracy; // 位置精度
	                  console.log("latitude : "+self.form.latitude+"--longitude : "+self.form.longitude+"--speed : "+self.form.speed+"--accuracy : "+self.form.accuracy);
	                }
	            });
	          });
	        },
	        setLocation: function(){
	          this.status.getLocation = true;
	          this.getSignature();
	          this.configuration();
	          this.wxReady();
	        },
	        //发送定位
	        onAllow: function(){
	          this.$http.post(this.domain+'/',this.location,{
	            emulateJSON:true,
	            crossOrigin: true,
	            headers:{
	              'Content-Type':'application/json; charset=UTF-8' 
	            }
	          }).then(function(res){
	            if(res.json().result == 1){
	              this.status.getLocation = false;
	            }
	          })
	        },
	        onCancel: function(){
	          this.status.getLocation = false;
	        },
			onRecommend:function(){
                this.status.isTutorInfo = false;
			},
			onMine: function(){
				window.location.href = './parentMyPage.html';
			},
			onAllTutor: function(){
              window.location.href = './parentAllTutor.html';				
			},
			onTutorInfo: function(index){
				this.status.isTutorInfo = true;
				this.status.selected = index; 
				this.detailedList = this.recommendList[index];
				if(this.recommendList[index].isInvited=="已邀请"){
					this.status.isDefault = true;
	                this.status.isSuccess = false;
	                this.status.isRegister = "取消邀请";
				}else if(this.recommendList[index].isInvited == "已报名"){
					this.status.isDefault = false;
	              	this.status.isSuccess = true;
					this.status.isRegister = "该老师已报名";
				}else if(this.recommendList[index].isInvited == "已拒绝"){
					this.status.isDefault = true;
	              	this.status.isSuccess = false;
					this.status.isRegister = "该老师已拒绝";
				}else if(this.recommendList[index].isInvited == "已完成"){
					this.status.isDefault = false;
	              	this.status.isSuccess = true;
					this.status.isRegister = "双方已成交";
				}
				else{					               
	              	this.status.isDefault = false;
	              	this.status.isSuccess = true;
	              	this.status.isRegister = "邀请老师";
				}

			},
			onRegister1: function(index){
				//邀请老师、取消邀请
				var invited,invitedText,successText;
				if(this.status.isRegister == "邀请老师"){
					invited = 1;
                    invitedText = '已邀请';
                    successText='邀请成功';
				}
				else if(this.status.isRegister == "取消邀请"){
					invited = 0;
                    invitedText = '';
                    successText='取消成功';
				}else{
					return false;
				}
				this.$http.post(this.domain+'/inviteTeacher',{
					'tea_id': this.recommendList[index].id,
					'type': invited
				},{
					emulateJSON:true,
					headers:{
						'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8'	
					}

				}).then(function(res){
					console.log(res.json());
					if(res.json().success==1){
				       this.status.isRegister =successText;
		                var self = this;
		                this.timer && clearTimeout(this.timer);
		                this.timer = setTimeout(function(){
		                 self.recommendList[index].isInvited = invitedText;
				         self.status.isTutorInfo = false;
		                }, 1000);
					}else{
						console.log(res.json().error);
						var self = this;
						this.status.errorTip = res.json().error;
						this.status.isTutorInfo = false;
						this.status.isInfoTipOne = true;
						this.timer && clearTimeout(this.timer);
						this.timer=setTimeout(function(){
                           self.status.isInfoTipOne = false;
						},1000);
					}
					
				})
			},
			onClose: function(){
	      		this.status.isTutorInfo = false;
	      	}	      	
		}
	})
})();