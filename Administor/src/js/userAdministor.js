(function(){
  Vue.http.interceptors.push(function(request, next){
      request.credentials = true;
      next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
      	timer: null,
        domain: 'http://www.yinzishao.cn:8000/',
      	status:{
      		isParent: true,
      		isTeacher: false,
      		isSelecting: true,
          isLoading: false,
          isDeleteInfo: false,
          selected: '',
          isList: true,
          key: '家长',
          isNoList: false
      	},
        numData:{
        	parentNum:0,
        	teacherNum: 0
        },
        form:{
          size: 15,
          start: 0,
        	user: 'parent',
          id: 0,
        	keyword: ''
        },
        jsonData: [],
        mainData:[],
      },
      ready:function(){
         this.getNum();
         if(location.search.indexOf("?") != -1 ){
          this.setOption();
         } 
         if(this.form.user == 'parent'){
          this.status.isParent = true;
          this.status.isTeacher = false;
         }else{
          this.status.isParent = false;
          this.status.isTeacher = true;
         }
         this.renderData();
         this.status.isLoading = true;
      },
      methods:{
        down: function(){
          this.form.size = 5;
          this.form.start++;
          if(this.jsonData.length!==0){
            this.renderData();
          }
        },
      	getNum:function(){
          this.$http.get(this.domain+'getNum',{
            crossOrigin: true,
          }).then(function(res) {
            if(res.json().success==1){
              this.numData.parentNum = res.json().parentNum;
              this.numData.teacherNum = res.json().teacherNum;
            }
          });
      	},
        setOption: function() {
          var search = location.search;
          if (search.indexOf("?") != -1) {
            search = search.substr(1, search.length).split("&");
            for (var i = 0, cell, length = search.length; i < length; i++) {
              cell = search[i].split('=');  
              if(cell[0]=='user'){
                this.form.user=cell[1];
              }       
              if(cell[0]=='keyword'){
                this.form.keyword=decodeURIComponent(cell[1]);
              }
            }
          }
        },
    		renderData: function(){
            this.status.isSelecting = true;
            var keyInfo;
            if(this.form.user == 'parent'){
              keyInfo = 'getParentOrder';
            }else{
              keyInfo = 'getTeachers';
            }
            this.$http.post(this.domain+keyInfo,{
              'size':this.form.size,
              'start': this.form.start,
              'keyword':this.form.keyword
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
                  this.status.isList = true;
                  this.status.isNoList = false;
                  var json=this.mainData.concat(data);
                  this.$set('mainData',json);
                  this.status.isSelecting = false;
                }else{
                  if(this.mainData.length == 0){
                    if(this.form.user == 'parent'){
                      this.status.key = '家长';
                    }else{
                      this.status.key = '老师';
                    }
                    this.status.isList = false;
                    this.status.isNoList = true;
                  }
                }
               
              }
            });
    		},
      	onUser:function(){
      		this.status.deleteInfo= false;
      	},
      	onDeal: function(){
          window.location.href = './deal.html';
      	},
      	onOther: function(){
          window.location.href = './other.html';
      	},
      	onParent: function(){
          this.form.user='parent';
          this.form.start = 0;
          this.form.size = 15;
          this.status.isParent = true;
          this.status.isTeacher = false;
          this.mainData = [];
          this.renderData();
      	},
      	onTeacher: function(){
      		this.form.user = 'teacher';
          this.form.start = 0;
          this.form.size = 15;
      		this.status.isTeacher = true;
      		this.status.isParent = false;
          this.mainData = [];
          this.renderData();
      	},
        onSearch: function(){
        	this.timer && clearTimeout(this.timer);
          this.form.start = 0;
          this.form.size = 15;
          this.mainData = [];
			    this.timer = setTimeout(this.renderData, 200);
        },
        onDelete: function(index){
           this.status.selected = index;
           this.status.isDeleteInfo = true;
           if(this.form.user == 'parent'){
            this.form.id = this.mainData[index].pd_id;
           }else{
            this.form.id = this.mainData[index].tea_id;
           }
        },
        //删除用户
        onSureDelete: function(index){        	
      		this.$http.post(this.domain+'deleteUser', {
            'id': this.form.id,
            'user': this.form.user
          },{
            crossOrigin: true,
  					headers:{
              'Content-Type':'application/json; charset=UTF-8' 
            }
  				}).then(function(res) {
            console.log(res.json());
  					if (res.json().success == 1) {       
  						this.status.isLoading = true;
  						this.status.isDeleteInfo = false;
              this.mainData.splice(index,1);
  					}
  					
  				});        
        },
        onCancel: function(){
          this.status.isDeleteInfo = false;
        },
        onDetailedInfo: function(index){ 
          if(this.form.user=='parent'){
            window.location.href = './detailedInfoParent.html?listId='+this.mainData[index].pd_id+'&keyword='+this.form.keyword;
          }else{
            window.location.href = './detailedInfoTeacher.html?listId='+this.mainData[index].tea_id+'&keyword='+this.form.keyword;
          }                
        }
      }
	});
})();