(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        timer: null,
        domain: 'http://www.yinzishao.cn',
        status:{
  	  	  isSelecting: true,
          isLoading: false,
          isUploadImg: false,
          selected: '',
          isSend: '',
          isGreen: true,
          isFeeInfo: false,
          isFeeInfoTrue: false,
          isList: true,
          isNoList: false,
          isEnlargeImg: false,
          enlargeImg: '',
      	},
      	mainData:[],
        detailedList: [],
        jsonData: [],
        para: {
          'size':15,
          'start':0
        },
      },
      ready: function(){
      	this.render();
        this.status.isLoading = true;
      },
      methods: {
        down: function(){
          this.form.size = 5;
          this.para.start++;
          if(this.jsonData.length!==0){
            this.render();
          }
        },
      	render: function(){
          var self = this;
          this.status.isSelecting = true;
           this.$http.post(this.domain+'/getDoneList',this.para,{
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
                for(var i =0;i<data.length;i++){
                  data[i].screenshot_path = this.domain+data[i].screenshot_path;
                  if(data[i].result == '未处理'){
                    data[i].isDeal= false;
                  }else{
                    data[i].isDeal = true;
                  }
                }
                var json=self.mainData.concat(data);
                this.$set('mainData',json);
                this.status.isSelecting = false;
              }else{
                if(this.mainData.length==0){
                  this.status.isList = false;
                  this.status.isNoList = true;
                }
              }
            }
           }) 
      	},
        onUser:function(){
          window.location.href = './userAdministor.html';
        },
        onOther: function(){
          window.location.href = './other.html';
        },
        onDeal: function(index){
          this.status.selected = index;
          this.status.isUploadImg = true;
          this.detailedList = this.mainData[index];
          if(this.mainData[index].result == '未处理'){
            this.status.isSend = '发送联系方式';
            this.status.isGreen = true;
          }else{
            this.status.isSend = '已发送';
            this.status.isGreen = false;
          }
        },
        onClose: function(){
        	this.status.isUploadImg = false;
        },
        onSubmitMsg: function(index){
          var list = this.mainData[index];
        	if(this.status.isSend == '发送联系方式'){
        		this.$http.post(this.domain+'/sendPhone',{
              "tea_id":list.tea,
              "oa_id":list.oa_id,
              "tel":list.parent_tel
            },{
              crossOrigin:true,
              headers:{
                'Content-Type':'application/json' 
              }

            }).then(function(res){
              if(res.json().success == 1){
                var self = this;
              	this.status.isSend = '已发送';
              	list.isDeal = false;
                this.timer && clearTimeout(this.timer);
                this.timer = setTimeout(function(){
                  list.isDeal = true;
                  list.result = '已成交';
                  self.status.isUploadImg = false;
                }, 1000); 
              }
            })
        	}else {
            this.status.isUploadImg = false;
        		return false;
        	}
        },
        showImg: function(){
          this.status.enlargeImg = this.mainData[this.status.selected].screenshot_path;
          this.status.isEnlargeImg = true;
        },
        closeImg: function(){
          this.status.isEnlargeImg = false;
        },
      }
	});
})()