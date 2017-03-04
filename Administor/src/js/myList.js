(function(){
	Vue.http.interceptors.push(function(request, next){
		request.credentials = true;
		next();
	});
	var vm = new Vue({
       el: 'body',
       data: {
         	domain:'http://www.yinzishao.cn',
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
            errorTip:'对不起，您只能选择一位老师'
    			},
			para:{
		        'start': 0,
		        'size': 16
		    },
		    jsonData:[],
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
          this.$http.post(this.domain+'/getAdminParent',this.para,{
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
       		window.location.href="./other.html";
       	},
        onTutorInfo:function(index){
          window.location.href = './detailedInfoParent.html?list=1&listId='+this.tutorList[index].pd_id;
        },
       }
	});
})();