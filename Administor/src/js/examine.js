(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
     el: 'body',
     data: {
      domain: 'http://shaozi.beansonbar.cn/',
     	status:{
     	  isLoading: false,
     	  sendResume: true,
     	  parRequest: false,
     	  isSelecting: true	,
        key: '简历',
        isList: true,
        isNoList : false
     	},
     	mainData:[],
      jsonData: [],
      para:{
        'size':16,
        'start': 0,
        'selected':1,
        'format':1,
      }
     },
     ready: function(){
      if(location.search.indexOf("?") != -1){
        this.getParam();
      }
     	// location.search.indexOf("?") != -1 && this.getParam();
     	this.getData();	
      this.status.isLoading = true;
     },
     methods:{
       down: function(){
        this.para.size = 5;
        this.para.start++;
        if(this.jsonData.length!= 0){
          this.getData();
        }
      },
     	getData: function(){
        this.$http.post(this.domain+'getCheckList',this.para,{
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
              this.status.isNoList = false;
              this.status.isList = true;
              var json=this.mainData.concat(res.json());
              this.$set('mainData',json);
              this.status.isSelecting = false;
            }else{
              if(this.mainData.length == 0){
                if(this.para.selected == 1){
                  this.status.key = '简历';
                }else{
                  this.status.key = '家长需求';
                }
                this.status.isNoList = true;
                this.status.isList = false;
              }
            }
          }	
        });
     	},
     	getParam: function(){
     		var str = location.search;
         if(str.indexOf('?') == -1){
         	return false;
         }else{
         	str = str.substr(1,str.length).split('=');
          var selected = parseInt(str[1]);
         	this.para.selected = selected;
         	if(selected==1){
         	  this.status.sendResume = true;
            this.status.parRequest = false;
         	}else{
         	  this.status.sendResume = false;
            this.status.parRequest = true;
         	}
         }
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
      onSendResume: function(){
       	this.status.sendResume = true;
       	this.status.parRequest = false;
        this.para.start = 0;
        this.para.size = 16;
       	this.para.selected = 1;
        this.mainData = [];
        this.getData();
      },
      onParRequest: function(){
       	this.status.sendResume = false;
       	this.status.parRequest = true;
        this.para.start = 0;
        this.para.size = 16;
       	this.para.selected = 2;
        this.mainData = [];
        this.getData();
      },
      onDetailed: function(index){
        var id,selectIndex;
        if(this.para.selected == 1){
          selectIndex = 1;
          id = this.mainData[index].tea_id;
        }else{
          selectIndex = 2;
          id = this.mainData[index].pd_id;
        }
        window.location.href='./examineDetailed.html?select='+selectIndex+'&listId='+id;
      },
      
     }
	});
})();