(function(){
	Vue.http.interceptors.push(function(request, next){
		request.credentials = true;
		next();
	});
	var vm = new Vue({
		el: 'body',
		data:{
			domain: 'http://www.shendaedu.com',
			// domain: 'http://shaozi.beansonbar.cn',
			timer: null,
			status:{
                isTutorInfo: false,
                isSuccess: '',
                isDefault: '',
                isInfoTipOne: false,
                selected: '',
                isRegister: '',
                isLoading: false,
                errorTip:'对不起，您只能选择一位老师',
                // getLocation: false,
                isTutor: true,
                isNoTutor: false,
                isEnlargeImg: false,
                enlargeImg: '',
                overY: false,
                isFinishMsg: false,
                informMsg: '',
			},
			recommendList:[],
			detailedList:[],
			jsonData:[],
			form: {
			  'size':9,
			  'start':0,
			  'hot':1
			},
			location:{
	          latitude:'',
	          longitude:'',
	        },
	        signature: '',
		},
		ready: function(){
			this.renderData();
			this.status.isLoading = true;
			this.getSignature();
		},
		methods:{
			down: function(){
			  this.form.size = 5;
              this.form.start++;
              if(this.jsonData.length!==0){
	            this.renderData();
	          }
			},
	        renderData: function(){
	        	this.$http.post(this.domain+'/getTeachers',this.form,{
	               crossOrigin: true,
	               headers:{
	                  'Content-Type':'application/json' 
	               }
	            }).then(function(res){
	              if(res.json().success == 0){
	              	console.log(res.json().error);
	              }else{
	              	console.log(res.json());
	              	this.jsonData = res.json();
	              	var data = res.json();
	              	if(data.length!=0){
	              		for(var i = 0;i<data.length;i++){
		              		if(data[i].certificate_photo!=''){
		              			data[i].certificate_photo = this.domain+data[i].certificate_photo;
		              		}else{
		              			data[i].certificate_photo = '../img/user.png';
		              		}
		              		var teach_photo=data[i].teach_show_photo,len=data[i].teach_show_photo.length;
		              		for(var j=0;j<len;j++){
	                           teach_photo[j]=this.domain+teach_photo[j];
		              		}
		              		if(data[i].distance!==0){
		              			data[i].distance = data[i].distance.toFixed(2);
		              		}
		              		if(data[i].isInvited == '您已拒绝'||data[i].isInvited == '老师已拒绝'||data[i].isInvited == '通知老师失败'){
			          	   		data[i].isRed = true;
			          	   	}else{
			          	   		data[i].isRed = false;
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
	                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	                appId: 'wx7a327445ac3309b4', // 必填，公众号的唯一标识
	                timestamp: 1482652615, // 必填，生成签名的时间戳
	                nonceStr:'yinzishao' , // 必填，生成签名的随机串
	                signature: self.signature,// 必填，签名，见附录1
	                jsApiList: ['getLocation','openLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	              });
               //    this.timer && clearTimeout(this.timer);
	              // this.timer = setTimeout(function(){
	              //    self.onAllow();
	              //  }, 300);
	            }else{
	              console.log(res.json().error);
	            }
	            
	          })                
	        },
	        sendLocation: function(){
	          this.$http.post(this.domain+'/setLocations',this.location,{
	            crossOrigin: true,
	            headers:{
	              'Content-Type':'application/json' 
	            }
	          }).then(function(res){
	            if(res.json().success == 1){
	            	this.form.start = 0;
	            	this.form.size = 9;
	            	this.recommendList = [];
	            	this.renderData();
	              // this.status.getLocation = false;
	            }
	          })
	        },
	        setLocation: function(){
	          // if(this.getSignature==''){
           //      this.getSignature();
	          // }else{
	          this.onAllow();
	          // }
	        },
	        //发送定位
	        onAllow: function(){
	          var self = this;
	          wx.ready(function	(){
	          	wx.getLocation({
		            type: 'wgs84',
		            success: function (res) {
		              // alert(JSON.stringify(res));
		              self.location.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		              self.location.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		              self.sendLocation();
		            },
		            
		        });
	          })
	          
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
				this.status.overY = true;
				this.status.isTutorInfo = true;
				this.status.selected = index; 
				this.status.isDefault = false;
				this.status.isSuccess = true;
				var selectList = this.recommendList[index];
				this.detailedList = selectList;
				switch(this.detailedList.isInvited){
					case '您已邀请':
					  this.status.isDefault = true;
	                  this.status.isSuccess = false;
	                  this.status.isRegister = "取消邀请";
	                  break;
	                case '向您报名':
	                  this.status.isRegister = "该老师已报名";
	                  break;
	                case '您已拒绝':
	                  this.status.isDefault = true;
	              	  this.status.isSuccess = false;
					  this.status.isRegister = "您已拒绝该老师";
					  break;
					case '老师已拒绝':
	                  this.status.isDefault = true;
	              	  this.status.isSuccess = false;
					  this.status.isRegister = "该老师已拒绝";
					  break;
                    case '您已同意':
	                  this.status.isRegister = "您已接受该老师";
	                  break;
	                case '正在通知老师':
	                  this.status.isRegister = "正在通知老师";
	                  break; 
	                case '已成功通知老师':
	                  this.status.isTutorInfo = false;
	                  this.status.isFinishMsg = true;
	                  this.status.informMsg = "已成功通知老师，用户名称："+selectList.name+"老师，联系方式："+selectList.tel+"，请尽快与老师联系确定试课，谢谢！";
	                  break; 
	                case '通知老师失败':
	                  this.status.isDefault = true;
	              	  this.status.isSuccess = false;
	              	  this.status.informMsg = "通知老师失败，请重新选择其他老师联系试课！";
	                  this.status.isTutorInfo = false;
	                  this.status.isFinishMsg = true;
	                  break; 
	                case '':
	                  this.status.isRegister = "邀请老师";
	                  break; 
				}

			},
			onRegister1: function(index){
				//邀请老师、取消邀请
				var invited,invitedText,successText;
				if(this.status.isRegister == "邀请老师"){
					invited = 1;
                    invitedText = '您已邀请';
                    successText='邀请成功';
				}
				else if(this.status.isRegister == "取消邀请"){
					invited = 0;
                    invitedText = '';
                    successText='取消成功';
				}else{
					this.status.isTutorInfo = false;
					return false;
				}
				this.$http.post(this.domain+'/inviteTeacher',{
					'tea_id': this.recommendList[index].tea_id,
					'type': invited
				},{
					emulateJSON:true,
					headers:{
						'Content-Type':'application/json'	
					}

				}).then(function(res){
					console.log(res.json());
					this.status.overY = false;
					if(res.json().success==1){
				       this.status.isRegister =successText;
		                var self = this;
		                this.timer && clearTimeout(this.timer);
		                this.timer = setTimeout(function(){
		                 self.recommendList[index].isInvited = invitedText;
				         self.status.isTutorInfo = false;
		                }, 400);
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
			showImg: function(index){
              this.status.enlargeImg = this.detailedList.teach_show_photo[index];
              this.status.isEnlargeImg = true;
			},
			closeImg: function(){
               this.status.isEnlargeImg = false;
			},
			onClose: function(){
	      		this.status.isTutorInfo = false;
	      		this.status.overY = false;
	      		this.status.isFinishMsg = false;
	      	}	      	
		}
	})
})();