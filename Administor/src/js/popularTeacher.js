(function(){
  Vue.http.interceptors.push(function(request, next){
    request.credentials = true;
    next();
  });
	var vm = new Vue({
      el: 'body',
      data: {
        domain: 'http://www.yinzishao.cn:8000/',
      	timer: null,
      	status:{
      		isSelecting: true,
          isLoading: false,
          selected: '',
          isList: true,
          isNoList: false
      	},
        jsonData: [],
        form:{
          size: 18,
          start: 0,
          hot: 1,
        	keyword: ''
        },
        mainData:[
          // {id: 0,name: '李小可',info: '设为热门'},
          // {id: 1,name: '张山',info: '设为热门'},
          // {id: 2,name: '黄大名',info: '设为热门'},
          // {id: 0,name: '李小可',info: '设为热门'},
          // {id: 1,name: '张山',info: '设为热门'},
          // {id: 2,name: '黄大名',info: '设为热门'},
        
        ],
        popularData:[]
      },
      ready:function(){
         if(location.search.indexOf("?")!=-1){
          this.setOption();
         }
         this.renderData();
         this.status.isLoading = true;
      },
      methods:{
        down: function(){
          this.form.size = 5;
          this.form.start++;
          if(this.jsonData.length !== 0){
            this.renderData();
          }
        },
        setOption: function() {
          var search = location.search;
          if (search.indexOf("?") != -1) {
            search = search.substr(1, search.length).split("&");
            for (var i = 0, cell, length = search.length; i < length; i++) {
              cell = search[i].split('=');              
              if(cell[0]=='keyword'){
                cell[1]=decodeURIComponent(cell[1]);
              }
              this.form.keyword = cell[1];
            }
          }
        },
    		renderData: function(){
            this.status.isSelecting = true;
            this.$http.post(this.domain+'getTeachers',this.form,{
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
                  this.status.isNoList = false;
                  this.status.isList = true;
                  for(var i =0;i<data.length;i++){
                    if(data[i].hot_not == 0){
                      data[i].info = '设为热门';
                    }else{
                      data[i].info = '取消热门';
                    }
                  }
                  var json=this.mainData.concat(data);
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
      	onOther: function(){
          window.location.href = './other.html';
      	},
        onSearch: function(){
          this.form.start = 0;
          this.mainData = [];
          this.form.size = 18;
        	this.timer && clearTimeout(this.timer);
			    this.timer = setTimeout(this.renderData, 200);
        },
        onPopular: function(index){ 
          var popular;
          if(this.mainData[index].info == '设为热门'){
            popular = 1;
          }else{
            popular = 0;
          }
          this.$http.post(this.domain+'setHot',{
            'id': this.mainData[index].tea_id,
            "type": popular,
            'user': "teacher"
          },{
            crossOrigin: true,
            headers:{
              'Content-Type':'application/json' 
            }

          }).then(function(res){
            console.log(res.json());
            if(res.json().success == 1){
              if(popular == 1){
                this.mainData[index].info = '取消热门';
                this.status.isSelecting = true;
                this.popularData = this.mainData[index];
                this.mainData.splice(index,1); //删除那一项
                this.mainData.unshift(this.popularData); //插入第一项
                this.status.isSelecting = false;
              }else{
                this.mainData[index].info = '设为热门';
              }
            }else{
              console.log(res.json().error);
            }
          });       
        },
        onDetailedInfo: function(index){ 
          window.location.href = './detailedInfoTeacher.html?page=popularTeacher&listId='+index+'&keyword='+this.form.keyword;                        
        }
      }
	});
})();