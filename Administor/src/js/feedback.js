(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        domain: 'http://www.yinzishao.cn/',
      	status:{
      		isSelecting: true,
          isLoading: false,
          selected: '',
          isFeedBack: false,
          isList: true,
          isNoList: false,
      	},
        mainData:[],
        msgList:[],
        jsonData: [],
        para: {
          'size':15,
          'start':0
        },
      },
      ready:function(){
         this.renderData();
         this.status.isLoading = true;
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
          this.status.isSelecting = true;
          this.$http.post(this.domain+'getFeedBack',this.para,{
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
                 var json=this.mainData.concat(res.json());
                 this.$set('mainData',json);
                 this.status.isSelecting = false;
              }else{
                if(this.mainData.length==0){
                  this.status.isNoList = true;
                  this.status.isList = false;
                }
              }            
            }            	
          });
    		},
        onReturn: function(){
          window.location.href='./other.html';
        },
      	onUser:function(){
      		window.location.href = './userAdministor.html'
      	},
      	onDeal: function(){
          window.location.href = './deal.html';
      	},
        onDetailedInfo: function(index){
          this.status.selected = index;
          this.msgList = this.mainData[index];
          this.status.isFeedBack = true;
        },
        onClose: function(){
          this.status.isFeedBack = false;
        }
      }
	});
})();