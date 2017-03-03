(function(){
	var vm = new Vue({
	  el: 'body',
	  data:{
	  	domain: 'http://www.yinzishao.cn',
        location:{
	      latitude:'',
	      longitude:'',
	      speed:'',
	      accuracy:'',
	    },
	  },
      ready:function(){
      	this.getSignature();
      },
      methods:{
        getSignature: function(){        
	      this.$http.post(this.domain+'/generate_signature',{
	        timestamp: 1482652615,
	        nonceStr: 'yinzishao',
	      },{
	        crossOrigin: true,
	        headers:{
	          'Content-Type':'application/json' 
	        }
	      }).then(function(res){
	        console.log(res.json());
	        this.signature = res.json().signature;
	        var self = this;
	        wx.config({
	          debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	          appId: 'wx6fe7f0568b75d925', // 必填，公众号的唯一标识
	          timestamp: 1482652615, // 必填，生成签名的时间戳
	          nonceStr:'yinzishao' , // 必填，生成签名的随机串
	          signature: self.signature,// 必填，签名，见附录1
	          jsApiList: ['checkJsApi','openLocation','getLocation','chooseImage','.uploadImage'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
	        });
	      })                
	    },
	    onGetLocation: function(){
	      var self = this;
	      wx.ready(function(){
	      //地理位置
	        wx.getLocation({
	          type: 'wgs84',
	            success: function (res) {
	              alert(JSON.stringify(res));
	              self.form.latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	              self.form.longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	              self.form.speed = res.speed; // 速度，以米/每秒计
	              self.form.accuracy = res.accuracy; // 位置精度
	              // this.onAllow();
	              alert("latitude : "+self.form.latitude+"--longitude : "+self.form.longitude+"--speed : "+self.form.speed+"--accuracy : "+self.form.accuracy);
	            }
	        });
	      });
	    },
	    //发送定位
	    onAllow: function(){
	      // this.wxReady();
	      this.$http.post(this.domain+'',this.location,{
	        crossOrigin: true,
	        headers:{
	          'Content-Type':'application/json' 
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
      }
	});
})();