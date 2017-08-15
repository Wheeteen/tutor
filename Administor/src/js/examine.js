(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
     el: 'body',
     data: {
      // domain: 'http://www.shendaedu.com/',
      domain: 'http://shaozi.beansonbar.cn/',
     	status:{
     	  isLoading: false,
     	  sendResume: true,
     	  parRequest: false,
        orderEx: false,
     	  isSelecting: true	,
        key: '简历',
        isList: true,
        isOrderList: false,
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
        var select = this.para.selected;
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
            var data = res.json(),
                len = data.length;
            if(len!==0){
              this.status.isNoList = false;
              if(select == 3){
                this.status.isOrderList = true;
                this.status.isList = false;
                for(var i =0;i<len;i++){
                  if(data[i].price !== null){
                    data[i].isDeal= false;
                    data[i].result = "已处理";            
                  }else{
                    data[i].isDeal = true;
                    data[i].result = "未处理";                  }
                }
              }else{
                this.status.isOrderList = false;
                this.status.isList = true;
              }
              var json=this.mainData.concat(data);
              this.$set('mainData',json);
              this.status.isSelecting = false;
            }else{
              if(this.mainData.length == 0){
                if(this.para.selected == 1){
                  this.status.key = '简历';
                }else if(this.para.selected == 2){
                  this.status.key = '家长需求';
                }else{
                  this.status.key = '订单';
                }
                this.status.isNoList = true;
                this.status.isList = false;
                this.status.isOrderList = false;
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
            this.status.orderEx = false;
         	}else if(selected==2){
         	  this.status.sendResume = false;
            this.status.parRequest = true;
            this.status.orderEx = false;
         	}else{
            this.status.sendResume = false;
            this.status.parRequest = false;
            this.status.orderEx = true;
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
        this.status.orderEx = false;
        this.para.start = 0;
        this.para.size = 16;
       	this.para.selected = 1;
        this.mainData = [];
        this.getData();
      },
      onParRequest: function(){
       	this.status.sendResume = false;
       	this.status.parRequest = true;
        this.status.orderEx = false;
        this.para.start = 0;
        this.para.size = 16;
       	this.para.selected = 2;
        this.mainData = [];
        this.getData();
      },
      onOrderEx: function(){
        this.status.sendResume = false;
        this.status.parRequest = false;
        this.status.orderEx = true;
        this.para.start = 0;
        this.para.size = 16;
        this.para.selected = 3;
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
      onOrderDetailed: function(index){
        var teaId,parId,oaId,data=this.mainData[index],pri;
        teaId = data.tea;
        parId = data.pd;
        oaId = data.oa_id;
        pri = data.price;
        if(pri!=null){
          window.location.href='./examineDetailed.html?select=3&listId='+oaId+'&teaId='+teaId+'&parId='+parId+'&price='+pri;
        }else{
          window.location.href='./examineDetailed.html?select=3&listId='+oaId+'&teaId='+teaId+'&parId='+parId;
        }       
      }
     }
	});
})();